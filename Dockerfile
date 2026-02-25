# Choisis la même base que ton service n8n utilise déjà si possible
FROM n8nio/n8n:latest

USER root

# ffmpeg + un minimum d’outils
RUN apt-get update \
  && apt-get install -y --no-install-recommends ffmpeg ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Revenir à l’utilisateur n8n
USER node