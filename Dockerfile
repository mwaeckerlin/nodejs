FROM mwaeckerlin/very-base AS build
RUN $PKG_INSTALL nodejs
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
ENV CONTAINERNAME    "node.js"
ENV NODE_ENV         "production"
ENV PATH             ""
CMD                  ["/usr/bin/node", "/app/dist/src/main"]
USER "${RUN_USER}"
WORKDIR /app
COPY --from=build /tmp/root /
