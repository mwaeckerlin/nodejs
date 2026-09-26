# Features

Numbered register of every feature; a number is never reused. Every feature is covered by tests listed in [TESTS.md](TESTS.md); the guard `tests/docs-contract.sh` fails when a feature has no test.

- **F1 — Headless Node.js runtime.** The image holds `node`, its shared libraries and the English ICU data of Alpine (`icu-data-en`; other locales format like English), and nothing else: no shell, no package manager, no npm.
- **F2 — Default entry point.** `node /app/dist/src/main` runs by default, which is where a NestJS build puts its entry point; a derived image sets another one with `CMD ["/app/dist/main"]`, because `node` is the entrypoint.
- **F3 — Production defaults.** `NODE_ENV` is `production`, the application runs as the unprivileged `somebody` in `/app`.
- **F4 — Published for amd64 and arm64.** Every push builds the image natively for both architectures and publishes it under one tag on Docker Hub, with the reusable workflow of `mwaeckerlin/scratch`.
