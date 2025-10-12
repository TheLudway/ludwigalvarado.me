# Docker Deployment for LXC

Simple Docker setup for LXC containers where the repository is pulled externally and the Docker container serves the static files.

## Quick Start

```bash
# Build and start
docker-compose up -d

# Or with plain docker commands:
docker build -t ludwigalvarado-site .
docker run -d --name ludwigalvarado-website -p 80:80 \
  -v $(pwd):/usr/share/nginx/html:ro \
  -v $(pwd)/logs:/var/log/nginx \
  ludwigalvarado-site
```

## How It Works

- **LXC** pulls git repository every N seconds
- **Docker container** runs nginx serving files from mounted directory  
- **No scripts** - just nginx serving static files
- **Auto-updates** when LXC pulls new changes

## Files

- `Dockerfile` - Simple nginx container
- `docker-compose.yml` - Service definition with volume mounts
- `nginx/nginx.conf` - Optimized nginx config
- `.dockerignore` - Excludes unnecessary files

## Health Check

```bash
curl http://localhost/health
```

## Logs

```bash
docker-compose logs -f
# or
docker logs -f ludwigalvarado-website
```

The container automatically serves updated files when LXC pulls new changes - no restart needed!