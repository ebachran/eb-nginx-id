#FROM alpine:latest

# Build certificates
#RUN make

FROM nginx:1.21.5

COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf
COPY static-html /usr/share/nginx/html

# Copy certificates from first stage
COPY server.crt server.key DoDRoots.crt /etc/nginx/
#COPY certificate.pem key.pem DoDRoots.crt /etc/nginx/
#COPY --from=0 certificate.pem key.pem DoDRoots.crt /etc/nginx/

#EXPOSE $PORT/tcp
#EXPOSE 443/tcp

CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'
