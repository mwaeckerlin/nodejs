FROM mwaeckerlin/very-base AS build
MAINTAINER mwaeckerlin
RUN whoami
RUN mkdir /app \
 && chown -R "${RUN_USER}" /app \
 && $PKG_INSTALL nodejs \
 && apk del --no-cache $(apk info | grep -v nodejs)

FROM mwaeckerlin/scratch
MAINTAINER mwaeckerlin
ENV CONTAINERNAME    "node.js"
ENV NODE_ENV         "production"
ENV PATH             ""
ENV SERVER           "index"
CMD                  [ "/usr/bin/node", "$SERVER" ]
USER "${RUN_USER}"
WORKDIR /app
COPY --from=build / /
