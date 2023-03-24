# Docker Image for Node.JS Projects.

Use [mwaeckerlin/nodejs-build](https://github.com/mwaeckerlin/nodejs-build) for building the images.

The image does not have a shell nor an package manager, but only nodejs and it's shared libraries. It is nearly the same as `gcr.io/distroless/nodejs`, but it is much smaller and therefore better (smaller attack vector):

    gcr.io/distroless/nodejs   latest              cf46b336f659         2 weeks ago        164MB
    mwaeckerlin/nodejs         latest              3099bad50ddc        26 minutes ago       56.2MB

The command runs by default (matches to NestJS built by [mwaeckerlin/schematics](https://github.com/mwaeckerlin/schematics)):

    /usr/bin/node /app/dist/src/main

If your main entry point is not in `/app/dist/src/main`, then just add a different `CMD` in your build, e.g.:

    CMD ["/usr/bin/node", "/app/dist/main"]