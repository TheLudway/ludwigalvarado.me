# Use official Nginx image
FROM nginx:alpine

# Copiar la config del NGINX del repo al contenedor
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiar la configuración del mime.types
COPY mime.types /etc/nginx/mime.types

# Remove the default website
RUN rm -rf /usr/share/nginx/html/*

# Copy your website files into the Nginx web directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
