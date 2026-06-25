#!/usr/bin/env bash
# 01 — Provision a fresh Ubuntu VM: Docker Engine + compose plugin + helpers.
# Run as a sudo-capable user.  Idempotent-ish.
set -euo pipefail

echo "==> Installing Docker Engine + compose plugin"
if ! command -v docker >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg git
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

echo "==> Adding $USER to docker group (log out/in to take effect)"
sudo usermod -aG docker "$USER" || true

echo "==> Installing certbot (for TLS, optional)"
sudo apt-get install -y certbot || true

docker --version
docker compose version
echo "==> Done. Re-login (or 'newgrp docker') so you can run docker without sudo."
