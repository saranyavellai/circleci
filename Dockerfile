ARG ALPINE_VERSION="3.12"
FROM alpine:${ALPINE_VERSION}
RUN echo "${ALPINE_VERSION}"
