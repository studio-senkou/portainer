# Portainer + Nginx SSL

Docker setup untuk Portainer dengan Nginx reverse proxy dan SSL.

## Quick Start

```bash
# Generate SSL certificate
make ssl

# Build dan start containers
make build
make up
```

Akses Portainer di: **https://localhost:8443**

## Commands

| Command | Description |
|---------|-------------|
| `make ssl` | Generate self-signed SSL certificate |
| `make build` | Build semua containers |
| `make up` | Start semua containers |
| `make down` | Stop semua containers |
| `make restart` | Restart semua containers |
| `make logs` | View logs semua containers |
| `make logs-nginx` | View logs Nginx |
| `make logs-portainer` | View logs Portainer |
| `make clean` | Hapus containers, volumes, dan images |

## Ports

| Port | Service | Description |
|------|---------|-------------|
| 8080 | HTTP | Redirect ke HTTPS |
| 8443 | HTTPS | Portainer via Nginx |

Untuk menggunakan port 80/443, set di `.env`:
```bash
HTTP_PORT=80
HTTPS_PORT=443
```

## Structure

```
├── docker/
│   ├── nginx/          # Nginx configuration
│   │   ├── Dockerfile
│   │   ├── nginx.conf
│   │   └── conf.d/
│   │       └── default.conf
│   └── portainer/      # Portainer configuration
│       └── Dockerfile
├── ssl/                # SSL certificates
├── docker-compose.yml
├── Makefile
└── .env.example
```

## Production SSL

Untuk production dengan Let's Encrypt:

1. Ganti certificates di folder `ssl/` dengan:
   - `cert.pem` - SSL certificate
   - `key.pem` - Private key

2. Atau gunakan certbot untuk generate:
```bash
certbot certonly --standalone -d yourdomain.com
cp /etc/letsencrypt/live/yourdomain.com/fullchain.pem ssl/cert.pem
cp /etc/letsencrypt/live/yourdomain.com/privkey.pem ssl/key.pem
```

## Docker Best Practices

- ✅ Alpine-based images untuk minimal footprint
- ✅ Health checks pada semua containers
- ✅ Resource limits (memory & CPU)
- ✅ Read-only Docker socket mount
- ✅ No new privileges security option
- ✅ Separate Dockerfile per service
- ✅ Named volumes untuk persistence
- ✅ Restart policies
