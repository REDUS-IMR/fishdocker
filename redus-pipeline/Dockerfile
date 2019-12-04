FROM redusimr/rstox:edge

COPY ./misc/run.sh ./misc/filebrowser.json ./misc/allrevproxy.conf /etc/

RUN apk add --no-cache --virtual builddep\
    R-dev \
    g++ \
    cmake \
    json-c-dev \
    bsd-compat-headers \
    openssl-dev \
    libwebsockets-dev \
    vim \
    zlib-dev\
    build-base \
    bash \
    curl \
  && apk add --no-cache \
    gcompat \
    json-c \
    libssl1.1 \
    libcrypto1.1 \
    libwebsockets \
    nginx \
    bash \
    make \
    screen \
## Install file browser
  && curl -fsSL https://filebrowser.xyz/get.sh | bash \
## Build newer ttyd (1.5.2)
  && cd /tmp \
  && wget https://github.com/tsl0922/ttyd/archive/1.5.2.tar.gz \
  && tar -zxvf 1.5.2.tar.gz \
  && cd ttyd-1.5.2 \
  && mkdir -p build \
  && cd build \
  && cmake .. \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_VERBOSE_MAKEFILE=TRUE \
  && make \
  && make install \
  && cd / \
## Install frontail (v.4.8.0)
  && wget https://github.com/mthenw/frontail/releases/download/v4.8.0/frontail-alpine -O /usr/local/bin/frontail \
  && chmod +x /usr/local/bin/frontail \
## Required permission and directories
  && chmod +x /etc/run.sh \
  && mv /etc/allrevproxy.conf /etc/nginx/conf.d/ \
  && mkdir -p /root/workspace \
  && mkdir -p /run/nginx \
## Install R packages for REDUS (including TAF, SAM, etc.)
  && Rscript -e 'install.packages(c("icesTAF", "areaplot"))' \
             -e 'install.packages(c("config", "memisc", "knitr", "httr"))' \
             -e 'install.packages(c("TMB", "ellipse", "RcppEigen"))' \
             -e 'install.packages(c("desc", "filelock"))' \
  && cd /tmp \
## Install REDUStools
  && curl -O https://codeload.github.com/REDUS-IMR/REDUStools/tar.gz/master \
  && tar -zxvf master \
  && R CMD INSTALL REDUStools-master \
## Install SAM
#  && curl -O https://codeload.github.com/fishfollower/SAM/tar.gz/multi \
#  && tar -zxvf multi \
#  && R CMD INSTALL SAM-multi/stockassessment \
## Cleaning up
  && apk del --no-cache builddep \
  && rm -rf /tmp/*

EXPOSE 8888

CMD ["/etc/run.sh"]

