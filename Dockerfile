# ---------------------------------
# STAGE 1: The "Build" Stage
# ---------------------------------
# Use an official Node.js image as the base.
# "alpine" is a lightweight version.
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first
# This takes advantage of Docker caching
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Run the React build script to create static files
RUN npm run build

# ---------------------------------
# STAGE 2: The "Production" Stage
# ---------------------------------
# Use a lightweight Nginx image as the final base
FROM nginx:stable-alpine

# Copy the custom Nginx configuration we created
# This will replace the default Nginx config
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copy *only* the built static files from the "builder" stage
# This is the key to a small image: we're not copying Node.js or node_modules
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80 (the default HTTP port)
EXPOSE 80

# Command to run Nginx in the foreground when the container starts
CMD ["nginx", "-g", "daemon off;"]