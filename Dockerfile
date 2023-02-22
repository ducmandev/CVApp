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
    && cp /app/nginx/react.conf /etc/nginx/conf.d/

# replicate www directory
RUN cp /app/dist /var/www/

CMD ["nginx", "-g", "daemon off;"]
