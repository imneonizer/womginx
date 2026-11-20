FROM nginx:1.30.7-alpine@sha256:caf4e1e032a20f9c3c5e28fc7f25ffd768ad8677b4975c54193075997b3a97e3
WORKDIR /opt/womginx
COPY . .

# modify nginx.conf
RUN chmod +x ./docker-sed.sh && ./docker-sed.sh

ENV PORT=80
# ENV SAFE_BROWSING=1

RUN cp /opt/womginx/nginx.conf /etc/nginx/nginx.conf
RUN nginx -t
CMD chmod +x ./docker-entrypoint.sh && ./docker-entrypoint.sh
