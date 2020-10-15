FROM redusimr/rstox:edge

COPY ./misc/run.sh ./misc/filebrowser.json ./misc/allrevproxy.conf /etc/

RUN apk add --no-cache --virtual builddep\
    R-dev \
    g++ \
    curl \
  && apk add --no-cache \
    nginx \
    bash \
    screen \
## Install file browser (v2.0.16)
  && wget -c https://github.com/filebrowser/filebrowser/releases/download/v2.0.16/linux-amd64-filebrowser.tar.gz -O - | tar zxvf - -C /usr/local/bin/ \
## Install ttyd (v1.6.0)
  && wget https://github.com/tsl0922/ttyd/releases/download/1.6.0/ttyd_linux.x86_64 -O /usr/local/bin/ttyd \
  && chmod +x /usr/local/bin/ttyd \
## Install frontail (v4.9.0)
  && wget https://github.com/mthenw/frontail/releases/download/v4.9.0/frontail-alpine -O /usr/local/bin/frontail \
  && chmod +x /usr/local/bin/frontail \
## Required permission and directories
  && chmod +x /etc/run.sh \
  && mv /etc/allrevproxy.conf /etc/nginx/conf.d/ \
  && mkdir -p /root/workspace \
  && mkdir -p /run/nginx \
## Install R packages for REDUS (including TAF, SAM, etc.)
  && Rscript -e 'install.packages(c("lattice", "bibtex", "areaplot"))' \
             -e 'install.packages(c("config", "memisc", "knitr", "httr"))' \
             -e 'install.packages(c("TMB", "ellipse", "RcppEigen"))' \
             -e 'install.packages(c("desc", "filelock"))' \
  && cd /tmp \
## Install icesTAF
  && curl -O https://codeload.github.com/ices-tools-prod/icesTAF/tar.gz/3.5-0 \
  && tar -zxvf 3.5-0 \
  && R CMD INSTALL icesTAF-3.5-0 \
## Install REDUStools
  && curl -O https://codeload.github.com/REDUS-IMR/REDUStools/tar.gz/master \
  && tar -zxvf master \
  && R CMD INSTALL REDUStools-master \
## Cleaning up
  && apk del --no-cache builddep \
  && rm -rf /tmp/*

EXPOSE 8888

CMD ["/etc/run.sh"]

