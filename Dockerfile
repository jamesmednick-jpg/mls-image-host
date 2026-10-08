# Public image host for Major League Socks' Amazon listing assets.
# Every file under public/ is served as-is at https://<domain>/<path>.
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY public/ /usr/share/nginx/html/
