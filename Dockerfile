FROM mwaeckerlin/very-base AS build
RUN $PKG_INSTALL nodejs
RUN $PKG_CLEANUP1
RUN $PKG_CLEANUP2
RUN rm /bin/busybox

FROM mwaeckerlin/scratch
ENV CONTAINERNAME    "node.js"
ENV NODE_ENV         "production"
ENV PATH             ""
CMD                  ["/usr/bin/node", "indev"]
USER "${RUN_USER}"
WORKDIR /app
COPY --from=build / /
