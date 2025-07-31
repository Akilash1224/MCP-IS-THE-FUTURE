# Enhanced n8n Docker Setup

This repository contains a production-ready n8n setup using Docker Compose with Traefik reverse proxy, PostgreSQL database, and Redis for queue management.

## Features

- 🔒 HTTPS enabled by default with self-signed certificates
- 🚦 Traefik reverse proxy with automatic SSL handling
- 📊 PostgreSQL database for data persistence
- 📬 Redis for improved queue management
- 🔄 Optional worker node for better performance
- 🛡️ Secure configuration with environment variables
- 🚀 Easy local development setup

## Prerequisites

- Docker and Docker Compose installed
- Basic understanding of Docker and n8n
- Windows or Linux environment

## Quick Start

1. Clone this repository:
```bash
git clone <repository-url>
cd n8n-enhanced
```

2. Generate SSL certificates (Windows):
```bash
.\generate-certs.bat
```

For Linux:
```bash
chmod +x generate-certs.sh
./generate-certs.sh
```

3. Configure environment variables:
```bash
cp .env.example .env
# Edit .env with your desired configuration
```

4. Start the stack:
```bash
docker compose up -d
```

5. Access n8n at: https://n8n.localhost

## Structure

```
.
├── .env                    # Environment variables
├── docker-compose.yml      # Docker services configuration
├── generate-certs.bat      # Windows SSL certificate generator
├── init-data.sh           # PostgreSQL initialization script
└── traefik/               # Traefik configuration
    ├── localhost.crt      # SSL certificate
    ├── localhost.key      # SSL private key
    └── tls.yml           # Traefik TLS configuration
```

## Services

### Traefik (Reverse Proxy)
- Port 80: HTTP (redirects to HTTPS)
- Port 443: HTTPS
- Port 8080: Traefik dashboard
- Self-signed certificates for local development
- Automatic HTTP to HTTPS redirection

### PostgreSQL
- Version: 15 Alpine
- Persistent data storage
- Configurable via environment variables
- Custom initialization script

### Redis
- Version: 7 Alpine
- Queue management
- Persistent data storage

### n8n
- Latest n8n version
- HTTPS enabled
- Integrated with PostgreSQL and Redis
- Configurable via environment variables
- Optional worker node for scalability

## Configuration

### Environment Variables

Key environment variables in `.env`:

```env
# Database Configuration
POSTGRES_DB=n8n
POSTGRES_USER=n8n
POSTGRES_PASSWORD=n8n_password

# n8n Configuration
N8N_HOST=n8n.localhost
N8N_PROTOCOL=https
N8N_PORT=5678

# Security
N8N_SECURE_COOKIE=true
N8N_USER_MANAGEMENT_DISABLED=false
```

### SSL Certificates

Self-signed certificates are automatically generated for local development. For production:

1. Comment out the self-signed certificate configuration in `docker-compose.yml`
2. Uncomment and configure the Let's Encrypt section
3. Update the domain and email settings

## Maintenance

### Backup

To backup your data:

1. PostgreSQL:
```bash
docker compose exec postgres pg_dump -U n8n n8n > backup.sql
```

2. n8n data:
```bash
docker compose cp n8n:/home/node/.n8n ./backup/
```

### Logs

View service logs:
```bash
docker compose logs -f [service_name]
```

### Updates

To update the stack:

```bash
docker compose pull
docker compose up -d
```

## Security Considerations

- Change default passwords in production
- Use real SSL certificates in production
- Enable user management
- Configure proper email settings
- Regularly update all components
- Backup data regularly

## Troubleshooting

1. Certificate issues:
   - Regenerate certificates using `generate-certs.bat`
   - Ensure proper domain configuration

2. Database connection issues:
   - Check PostgreSQL logs
   - Verify environment variables
   - Ensure proper network connectivity

3. Performance issues:
   - Enable worker node
   - Monitor resource usage
   - Adjust PostgreSQL configuration

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.