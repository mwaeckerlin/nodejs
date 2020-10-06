# Docker Image for Node.JS Projects.

Use [mwaeckerlin/nodejs-build](/mwaeckerlin/nodejs-build) for building the images.

The image does not have a shell nor an package manager, but only nodejs and it's shared libraries. It is nearly the same as `gcr.io/distroless/nodejs`, but it is much smaller and therefore better (smaller attack vector):

    gcr.io/distroless/nodejs   latest              120fbef4aff7        50 years ago        119MB
    mwaeckerlin/nodejs         latest              189ef943b5d6        About a minute ago   36.1MB
