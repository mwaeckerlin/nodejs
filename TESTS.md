# Tests

Register of all tests, sorted by the [FEATURES.md](FEATURES.md) number each test covers. `npm test` runs everything; the guard `tests/docs-contract.sh` fails when a feature has no test entry here.

## Image contract

- **F1** `tests/image-contract.sh` › no sh, no bash, no busybox, no perl — the image is headless.
- **F1** `tests/config-contract.sh` › icu_data_present — `Intl` formats a number for `en-US`, so the ICU data arrived in the image.
- **F1** `tests/config-contract.sh` › node_is_current_lts — `process.versions.node` has the major version of `NODE_VERSION` in `node:lts-alpine` (regression: 24.22 from the Alpine package `nodejs`, while the LTS was 26).
- **F2** `tests/config-contract.sh` › default_main_runs_as_somebody, cmd_override_runs — a child image with `/app/dist/src/main.js` runs without any `CMD`, and one with `CMD ["/app/dist/main"]` runs its own entry point.
- **F3** `tests/config-contract.sh` › default_main_runs_as_somebody, node_env_production, workdir_app — the application runs as `somebody`, in production mode, in `/app`.

## Workflow contract

- **F4** `tests/workflow-contract.sh` of `mwaeckerlin/scratch` — the reusable workflow selects exactly the images a repository publishes; this repository calls it from `.github/workflows/docker.yml`.
