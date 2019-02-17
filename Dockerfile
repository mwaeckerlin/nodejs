FROM mwaeckerlin/base
MAINTAINER mwaeckerlin

ENV CONTAINERNAME    "node.js"
ENV NODE_ENV         "production"
ENV PATH             "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/app/node_modules/.bin"
RUN mkdir /app \
 && chown -R "${RUN_USER}" /app \
 && apk add --no-cache --purge --clean-protected -u nodejs npm
USER "${RUN_USER}"
WORKDIR /app
