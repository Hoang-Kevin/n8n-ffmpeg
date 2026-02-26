FROM alpine:latest AS alpine

FROM n8nio/n8n:latest

# Restore apk (removed from hardened n8n image) from a matching Alpine runtime.
COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /usr/lib/libapk.so* /usr/lib/

USER root

RUN apk add --no-cache ffmpeg