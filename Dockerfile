FROM mwaeckerlin/very-base AS build
# nodejs-current carries the active LTS on Alpine 3.24 (26.x), the package
# nodejs the previous one (24.x); where the package moves away from
# node:lts-alpine, the test node_is_current_lts fails
RUN $PKG_INSTALL nodejs-current
RUN for file in \
    /usr/bin/node \
    /usr/share/icu \
    $(ldd /usr/bin/node | sed -n 's,.* \([^ ]*/lib/[^ ]*\) .*,\1,p'); \
    do \
    path=${file%/*}; \
    test -d /tmp/root/$path || mkdir -p /tmp/root/$path; \
    cp -Lr $file /tmp/root/$file; \
    done

FROM mwaeckerlin/scratch
ENV CONTAINERNAME="node.js"
ENV NODE_ENV="production"
ENV PATH=""
ENTRYPOINT ["/usr/bin/node"]
CMD ["/app/dist/src/main"]
USER "${RUN_USER}"
WORKDIR /app
COPY --from=build /tmp/root /
