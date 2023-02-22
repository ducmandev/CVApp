FROM node:14

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.19

COPY --from=0 /app/build /usr/share/nginx/html
# create the nginx pid directory
RUN mkdir -p /run/nginx \
    && chown -R nginx:nginx /run/nginx

COPY react.conf /etc/nginx/conf.d/
# Copy the nginx conf to sites-enabled
RUN rm -rf /etc/nginx/conf.d/* \
    && cp ./react.conf /etc/nginx/conf.d/

# replicate www directory
RUN cp -r ./public /var/www/


EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]
