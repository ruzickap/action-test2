FROM alpine:edge

LABEL maintainer="Petr Ruzicka <petr.ruzicka@gmail.com>"
LABEL repository="https://github.com/ruzickap/raw-photo-tools-container"
LABEL homepage="https://github.com/ruzickap/raw-photo-tools-container"

# hadolint ignore=DL3018
RUN set -eux && \
    apk add --no-cache darktable exiftool
