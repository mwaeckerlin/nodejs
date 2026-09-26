#!/usr/bin/env bash
# Config contract: a Node.js application runs on the runtime base.
#
# A child image is built FROM the local image with a small application in the
# default location and one in another location, the way the README tells a
# user to do it; both must run as the unprivileged user in production mode.
#
# Usage: tests/config-contract.sh IMAGE

set -uo pipefail

IMAGE="${1:?usage: tests/config-contract.sh IMAGE}"
CHILD="${IMAGE%%:*}-config-contract-child"
CONTEXT=$(mktemp -d)
trap 'rm -rf "${CONTEXT}"; docker image rm -f "${CHILD}" "${CHILD}-cmd" > /dev/null 2>&1' EXIT

PASS=0
FAIL=0
declare -a FAILED_NAMES

_pass() { PASS=$((PASS + 1)); echo "  PASS  $1"; }
_fail() { FAIL=$((FAIL + 1)); FAILED_NAMES+=("$1"); echo "  FAIL  $1: $2"; }

echo "==> Config contract: Node.js runtime base"

if ! docker image inspect "${IMAGE}" > /dev/null 2>&1; then
    _fail "${IMAGE}_image_exists" "image not built — run 'npm run build' first"
else
    mkdir -p "${CONTEXT}/dist/src"
    cat > "${CONTEXT}/dist/src/main.js" <<'EOF'
const os = require('os')
console.log(JSON.stringify({user: os.userInfo().username, env: process.env.NODE_ENV, cwd: process.cwd(), intl: new Intl.NumberFormat('en-US').format(1234.5)}))
EOF
    cp "${CONTEXT}/dist/src/main.js" "${CONTEXT}/dist/main.js"
    printf 'FROM %s\nCOPY dist /app/dist\n' "${IMAGE}" > "${CONTEXT}/Dockerfile"
    printf 'FROM %s\nCOPY dist /app/dist\nCMD ["/app/dist/main"]\n' "${IMAGE}" > "${CONTEXT}/Dockerfile.cmd"

    if docker build --quiet -t "${CHILD}" "${CONTEXT}" > /dev/null 2>&1; then
        OUT=$(docker run --rm --pull=never "${CHILD}" 2>&1)
        if [[ "${OUT}" == *'"user":"somebody"'* ]]; then _pass "default_main_runs_as_somebody"; else _fail "default_main_runs_as_somebody" "${OUT}"; fi
        if [[ "${OUT}" == *'"env":"production"'* ]]; then _pass "node_env_production"; else _fail "node_env_production" "${OUT}"; fi
        if [[ "${OUT}" == *'"cwd":"/app"'* ]]; then _pass "workdir_app"; else _fail "workdir_app" "${OUT}"; fi
        if [[ "${OUT}" == *'"intl":"1,234.5"'* ]]; then _pass "icu_data_present"; else _fail "icu_data_present" "${OUT}"; fi
    else
        _fail "default_main_runs_as_somebody" "child image does not build"
    fi

    if docker build --quiet -t "${CHILD}-cmd" -f "${CONTEXT}/Dockerfile.cmd" "${CONTEXT}" > /dev/null 2>&1; then
        OUT=$(docker run --rm --pull=never "${CHILD}-cmd" 2>&1)
        if [[ "${OUT}" == *'"user":"somebody"'* ]]; then _pass "cmd_override_runs"; else _fail "cmd_override_runs" "${OUT}"; fi
    else
        _fail "cmd_override_runs" "child image with CMD does not build"
    fi
fi

echo ""
echo "==> Config contract results: ${PASS} passed, ${FAIL} failed"
if [[ ${FAIL} -gt 0 ]]; then
    echo "==> Failed contracts: ${FAILED_NAMES[*]}"
    exit 1
fi
