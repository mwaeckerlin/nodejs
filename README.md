# Docker Image for Node.JS Projects

This is the **production runtime base** for Node.JS services: use it as the **final stage** of a multi-stage build. Do the building in [mwaeckerlin/nodejs-build](https://github.com/mwaeckerlin/nodejs-build) — that image is build-only and must never run in production.

The image does not have a shell nor a package manager, but only nodejs of the current LTS (Alpine package `nodejs-current`), its shared libraries and the English ICU data (`Intl` formats every locale like English). It is nearly the same as `gcr.io/distroless/nodejs`, but it is much smaller and therefore better (smaller attack vector):

```text
gcr.io/distroless/nodejs   latest              cf46b336f659         2 weeks ago        164MB
mwaeckerlin/nodejs         latest              3099bad50ddc        26 minutes ago       56.2MB
```

The image is published for `linux/amd64` and `linux/arm64`. The application runs as the unprivileged user `somebody` in `/app`, with `NODE_ENV=production`.

## Entry point

The command runs by default (matches to NestJS built by [mwaeckerlin/schematics](https://github.com/mwaeckerlin/schematics)):

```text
/usr/bin/node /app/dist/src/main
```

`node` is the entrypoint, so if your main entry point is not in `/app/dist/src/main`, add a `CMD` with the script only, e.g.:

```Dockerfile
CMD ["/app/dist/main"]
```

## Development

```bash
npm run build
npm test
```

`npm test` checks the feature register ([FEATURES.md](FEATURES.md), [TESTS.md](TESTS.md)), the headless image contract and runs a small application in a child image. The architecture is described in [ARCHITECTURE.md](ARCHITECTURE.md). The image is built and published by the reusable workflow of [mwaeckerlin/scratch](https://github.com/mwaeckerlin/scratch#publishing-on-docker-hub).
