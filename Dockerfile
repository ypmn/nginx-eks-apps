FROM phanikumary1995/nginx
RUN apt-get update && apt-get install -y iputils-ping
RUN apt-get update && apt-get install -y curl
COPY nginx.conf /etc/nginx/nginx.conf
#RUN mkdir -p /opt/cert
COPY virtual-hosts.com /etc/nginx/sites-available/virtual-hosts.com
RUN ln -s /etc/nginx/sites-available/virtual-hosts.com /etc/nginx/sites-enabled/virtual-hosts.com
#COPY ssl_cert/* /opt/cert/
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
