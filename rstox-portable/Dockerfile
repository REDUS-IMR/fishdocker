FROM redusimr/rstox:latest

COPY ./misc/run.sh ./misc/filebrowser.json ./misc/allrevproxy.conf /etc/

RUN apk add --no-cache --virtual builddep\
    bash \
    curl \
  && apk add --no-cache \
    ttyd \
    nginx \
## Install file browser
  && curl -fsSL https://filebrowser.github.io/get.sh | bash \
## Required permission and directories
  && chmod +x /etc/run.sh \
  && mv /etc/allrevproxy.conf /etc/nginx/conf.d/ \
  && mkdir -p /root/workspace \
  && mkdir -p /run/nginx \
## Cleaning up
  && apk del --no-cache builddep \
  && rm -rf /tmp/*

EXPOSE 8888

CMD ["/etc/run.sh"]

