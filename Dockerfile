# Optimized Dockerfile for LXC deployment with external git pulling
FROM nginx:alpine

# Install basic tools and set timezone
RUN apk add --no-cache curl tzdata && \
    cp /usr/share/zoneinfo/America/Bogota /etc/localtime && \
    echo "America/Bogota" > /etc/timezone

# Copy nginx configuration files
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx/mime.types /etc/nginx/mime.types

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy website files (these will be overridden by LXC volume mount)
COPY css/ /usr/share/nginx/html/css/
COPY documents/ /usr/share/nginx/html/documents/
COPY favicons/ /usr/share/nginx/html/favicons/
COPY images/ /usr/share/nginx/html/images/
COPY keys/ /usr/share/nginx/html/keys/
COPY index.html /usr/share/nginx/html/
COPY google920c627fe60dd078.html /usr/share/nginx/html/

# Set proper ownership and permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 644 /usr/share/nginx/html && \
    find /usr/share/nginx/html -type d -exec chmod 755 {} \;

# Health check for LXC monitoring
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

# Expose port 80
EXPOSE 80

# Start nginx (no custom entrypoint needed)
CMD ["nginx", "-g", "daemon off;"]
