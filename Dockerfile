# Use official Nginx image
FROM nginx:alpine

# Config para una vuelta del text
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Remove the default website
RUN rm -rf /usr/share/nginx/html/*

# Copy your website files into the Nginx web directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
