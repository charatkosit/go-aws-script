# Use an official Node runtime as the base image
FROM node:16.20.1

# Set working directory in container
WORKDIR /srv/app

# Install Strapi
RUN npm install -g strapi@latest

# Set environment variables (or you can set them directly in your docker-compose.yml)
ENV DATABASE_CLIENT=mysql
ENV DATABASE_HOST=db
ENV DATABASE_PORT=3306
ENV DATABASE_NAME=strapi
ENV DATABASE_USERNAME=strapi
ENV DATABASE_PASSWORD=strapi

# Expose API port
EXPOSE 1337

# Run the application
CMD ["strapi", "develop"]
