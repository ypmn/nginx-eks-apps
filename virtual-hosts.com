#############################################################################
#                            Test-app                                       #
#############################################################################
server {
    listen            80;
    listen       [::]:80;
    server_name  app.rijwikes.com;

    location / {
        resolver 8.8.8.8;
        proxy_read_timeout    90;
        proxy_connect_timeout 90;
        proxy_redirect        off;
        proxy_pass http://springboot.default.svc.cluster.local:8080;

        proxy_set_header      X-Real-IP $remote_addr;
        proxy_set_header      X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header      Host $host;
    }
  # force https-redirects
    if ($http_x_forwarded_proto = 'http'){
    return 301 https://$host$request_uri;
    }
}
