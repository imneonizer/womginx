#!/bin/sh

set -e
config_file=/etc/nginx/nginx.conf

# environment variables are set at runtime, so modify the conf only when it starts
sed -i "s/listen 80/listen $PORT/" $config_file

# disable ssl (since we're running this behind a reverse proxy like heroku)
if [ $DISABLE_SSL == 'true' ];then
    echo SSL is disabled
    sed -i '/ssl_certificate/d' $config_file
    sed -i '/listen 443/d' $config_file
fi


if [ ! -z "$SAFE_BROWSING" ]; then
    sed -i "s/1.1.1.1/1.1.1.3/" $config_file
fi

# default.conf makes docker listen to 80, and
# heroku's non-root user running this won't like it at all
rm -rf /etc/nginx/conf.d/default.conf

nginx
