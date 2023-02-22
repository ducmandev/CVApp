FROM node:11-alpine

# install nginx
RUN apk add nginx

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 80

# Copy the nginx conf to sites-enabled
RUN rm -rf /etc/nginx/conf.d/* \
    && cp ./react.conf /etc/nginx/conf.d/

# replicate www directory
RUN cp ./public/* /var/www/

CMD ["nginx", "-g", "daemon off;"]
