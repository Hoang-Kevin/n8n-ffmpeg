# ---- Stage 1: builder avec apk ----
FROM alpine:3.22 AS ffmpeg_builder

RUN apk add --no-cache ffmpeg

# ---- Stage 2: image finale (hardened n8n) ----
# IMPORTANT: garde exactement la même image de base que ton template Railway utilise
# (remplace ce FROM par celui du template si ce n’est pas n8nio/n8n:latest)
FROM n8nio/n8n:latest

USER root

# Binaries
COPY --from=ffmpeg_builder /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg_builder /usr/bin/ffprobe /usr/bin/ffprobe

# Libs (Alpine = musl). Le plus simple/robuste: copier les libs nécessaires.
COPY --from=ffmpeg_builder /usr/lib/ /usr/lib/
COPY --from=ffmpeg_builder /lib/ /lib/

# Optionnel mais parfois utile (mime/types, etc.)
COPY --from=ffmpeg_builder /etc/ /etc/

USER node