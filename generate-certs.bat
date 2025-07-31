@echo off
echo Generating SSL certificates for n8n...

REM Create traefik directory
if not exist traefik mkdir traefik

REM Generate self-signed certificate using Docker
docker run --rm -v "%cd%\traefik:/certs" alpine/openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /certs/localhost.key -out /certs/localhost.crt -subj "/C=US/ST=Local/L=Local/O=Local/OU=Local/CN=localhost" -addext "subjectAltName=DNS:localhost,DNS:n8n.localhost,DNS:*.localhost,IP:127.0.0.1"

REM Create Traefik TLS configuration
echo tls: > traefik\tls.yml
echo   certificates: >> traefik\tls.yml
echo     - certFile: /etc/traefik/dynamic/localhost.crt >> traefik\tls.yml
echo       keyFile: /etc/traefik/dynamic/localhost.key >> traefik\tls.yml

echo.
echo SSL certificates generated successfully!
pause