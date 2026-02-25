# ---- Stage 1: builder ----
FROM alpine:3.22 AS ffmpeg_builder
RUN apk add --no-cache ffmpeg

# ---- Stage 2: image finale hardened ----
FROM n8nio/n8n:latest   # ⚠️ remplace par EXACTEMENT l'image utilisée par Railway

USER root

# créer un user non-root si nécessaire
RUN addgroup -S node && adduser -S node -G node

# copier ffmpeg + libs
COPY --from=ffmpeg_builder /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg_builder /usr/bin/ffprobe /usr/bin/ffprobe
COPY --from=ffmpeg_builder /usr/lib/ /usr/lib/
COPY --from=ffmpeg_builder /lib/ /lib/

# permissions
RUN chown -R node:node /usr/bin/ffmpeg /usr/bin/ffprobe

USER node