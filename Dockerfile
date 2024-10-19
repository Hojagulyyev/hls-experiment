FROM nginx:latest

COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./twitch_2p /var/www/html/videos

RUN chmod -R 755 /var/www/html/videos
RUN chown -R www-data:www-data /var/www/html/videos
