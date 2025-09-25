# Use official Nginx image
FROM nginx:alpine

# Copiar la config del NGINX del repo al contenedor
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copiar la configuración del mime.types
COPY nginx/mime.types /etc/nginx/mime.types

# Remove the default website
RUN rm -rf /usr/share/nginx/html/*

# Copy web files
COPY css/ /usr/share/nginx/html/css/
COPY documents/ /usr/share/nginx/html/documents/
COPY favicons/ /usr/share/nginx/html/favicons/
COPY images/ /usr/share/nginx/html/images/
COPY keys/ /usr/share/nginx/html/keys/
COPY index.html /usr/share/nginx/html/
COPY google920c627fe60dd078.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
