server {
    server_name ducmandev.com;
    root /var/www/MYCV;

    location / {
        try_files $uri /index.html;
    }
}
