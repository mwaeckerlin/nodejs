FROM mwaeckerlin/very-base AS build
RUN $PKG_INSTALL nodejs
RUN for file in \
        /etc/passwd \
        /usr/bin/node \
        $(ldd /usr/bin/node | sed -n 's,.* \([^ ]*/lib/[^ ]*\) .*,\1,p'); \
    do \
        path=${file%/*}; \
        test -d /tmp/root/$path || mkdir -p /tmp/root/$path; \
        cp -L $file /tmp/root/$file; \
        done

FROM mwaeckerlin/scratch
ENV CONTAINERNAME    "node.js"
ENV NODE_ENV         "production"
ENV PATH             ""
CMD                  ["/usr/bin/node", "index"]
USER "${RUN_USER}"
WORKDIR /app
COPY --from=build /tmp/root /
