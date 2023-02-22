FROM node:11-alpine

# install nginx
RUN apk add nginx

# create the nginx pid directory
RUN mkdir -p /run/nginx \
    && chown -R nginx:nginx /run/nginx

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 80

# Copy the nginx conf to sites-enabled
RUN rm -rf /etc/nginx/conf.d/* \
    && cp ./react.conf /etc/nginx/conf.d/

# replicate www directory
RUN cp -r ./public /var/www/

CMD ["nginx", "-g", "daemon off;"]
