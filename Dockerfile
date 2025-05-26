# Use official Nginx image
FROM nginx:alpine

# Remove the default website
RUN rm -rf /usr/share/nginx/html/*

# Copy your website files into the Nginx web directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
