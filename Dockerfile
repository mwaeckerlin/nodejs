FROM mwaeckerlin/base
MAINTAINER mwaeckerlin

ENV CONTAINERNAME    "node.js"
ENV NODE_ENV         "production"
ENV NODE_USER        "npm"
RUN adduser -S "${NODE_USER}" "${SHARED_GROUP_NAME}" \
 && mkdir /app \
 && chown -R "${NODE_USER}" /app \
 && apk add nodejs npm \
 && npm install npm@latest -g
USER "${NODE_USER}"
WORKDIR /app
