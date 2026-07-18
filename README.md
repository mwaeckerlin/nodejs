# Docker Image for Node.JS Projects.

This is the **production runtime base** for Node.JS services: use it as the **final stage** of a multi-stage build. Do the building in [mwaeckerlin/nodejs-build](https://github.com/mwaeckerlin/nodejs-build) — that image is build-only and must never run in production.

The image does not have a shell nor a package manager, but only nodejs and its shared libraries. It is nearly the same as `gcr.io/distroless/nodejs`, but it is much smaller and therefore better (smaller attack vector):

    gcr.io/distroless/nodejs   latest              cf46b336f659         2 weeks ago        164MB
    mwaeckerlin/nodejs         latest              3099bad50ddc        26 minutes ago       56.2MB

The command runs by default (matches to NestJS built by [mwaeckerlin/schematics](https://github.com/mwaeckerlin/schematics)):

    /usr/bin/node /app/dist/src/main

If your main entry point is not in `/app/dist/src/main`, then just add a different `CMD` in your build, e.g.:

    CMD ["/usr/bin/node", "/app/dist/main"]