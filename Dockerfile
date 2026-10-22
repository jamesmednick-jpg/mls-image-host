# Public image host for Major League Socks' Amazon listing assets.
# The images live in the GitHub repo; the build pulls that exact commit so the CLI upload stays tiny
# (railway up rejects bundles over ~500 MB). Every file under public/ is served at the same path.
FROM alpine:3.20 AS assets
ARG REPO=jamesmednick-jpg/mls-image-host
ARG COMMIT=c138e879bde19ddb96da6e6b06bb7f0f592e211f
RUN apk add --no-cache curl tar \
 && curl -fsSL "https://codeload.github.com/${REPO}/tar.gz/${COMMIT}" -o /tmp/src.tgz \
 && mkdir -p /src && tar -xzf /tmp/src.tgz -C /src --strip-components=1 && rm /tmp/src.tgz \
 && find /src/public -type f | wc -l

FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=assets /src/public/ /usr/share/nginx/html/
