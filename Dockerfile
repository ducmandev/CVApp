# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container to /app
WORKDIR /app

# Copy the package.json and package-lock.json to the container
COPY package*.json ./

# Install the app's dependencies
RUN npm install

# Copy the rest of the app's files to the container
COPY . .

# Build the app
RUN npm run build

# Use Nginx as the final image
FROM nginx:1.19

# Copy the built app to the Nginx image
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80 from the container
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]