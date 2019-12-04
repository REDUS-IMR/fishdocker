FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF
ARG REL_LATEST

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.license="LGPL-3.0" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/REDUS-IMR/fishdocker" \
      org.label-schema.vendor="REDUS Project at IMR Norway"

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    && apk add --no-cache --virtual builddep openjdk8 \
	proj-dev \
	gdal-dev \
	geos-dev \
	libxml2-dev \
	curl \
        R-dev \
	libc-dev \
	g++ \
    && apk add --no-cache R \
	R-doc \
	ttf-liberation \
	libxml2 \
	openjdk8-jre-base \
	proj \
	gdal \
	geos \
	libxml2 \
    && echo "options(repos = c(CRAN = 'https://cloud.r-project.org/'), download.file.method = 'libcurl')" >> /usr/lib/R/etc/Rprofile.site \
    && JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk R CMD javareconf \
    && cd /tmp \
    && curl -O https://codeload.github.com/Sea2Data/Rstox/tar.gz/${REL_LATEST} \
    && tar -zxvf ${REL_LATEST} \
    && Rscript -e "lapply(c(\"data.table\", \"ggplot2\", \"pbapply\", \"rgdal\", \"rgeos\", \"rJava\", \"sp\", \"XML\", \"gridExtra\", \"plotrix\", \"scatterpie\"), install.packages)" \
    && R CMD INSTALL Rstox-* \
    && curl -LO https://github.com/iambaim/new-reca/releases/download/Reca-v1.2/Reca_1.2_R_x86_64-pc-linux-gnu.tar.gz \
    && tar -zxvf Reca_1.2_R_x86_64-pc-linux-gnu.tar.gz \
    && R CMD INSTALL Reca \
    && apk del --no-cache builddep \
    && rm -rf /tmp/*

