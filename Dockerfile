FROM nginx:1.19-alpine
WORKDIR /opt/womginx
COPY . .

# modify nginx.conf
RUN chmod +x ./docker-sed.sh && ./docker-sed.sh

ENV PORT=80
# ENV SAFE_BROWSING=1

RUN cp /opt/womginx/nginx.conf /etc/nginx/nginx.conf
RUN nginx -t
CMD chmod +x ./docker-entrypoint.sh && ./docker-entrypoint.sh
