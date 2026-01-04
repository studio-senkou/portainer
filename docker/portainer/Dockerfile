FROM portainer/portainer-ce:2.21.5-alpine

EXPOSE 9000

HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:9000/api/system/status || exit 1
