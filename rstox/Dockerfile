FROM redusimr/r-tidyverse:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.license="LGPL-3.0" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/REDUS-IMR/fishdocker" \
      org.label-schema.vendor="REDUS Project at IMR Norway"

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    && apk --update add --no-cache --virtual builddep openjdk8 \
	proj4-dev \
	gdal-dev \
	geos-dev \
	libxml2-dev \
	curl \
        R-dev \
	libc-dev \
	g++ \
    && apk --update add --no-cache openjdk8-jre-base \
	proj4 \
	gdal \
	geos \
	libxml2 \
    && JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk R CMD javareconf \
    && cd /tmp \
    && curl -O https://codeload.github.com/Sea2Data/Rstox/tar.gz/develop \
    && tar -zxvf develop \
    && Rscript -e "lapply(c(\"data.table\", \"pbapply\", \"rgdal\", \"rgeos\", \"rJava\", \"sp\", \"XML\"), install.packages)" \
    && R CMD INSTALL Rstox-develop \
    && apk del --no-cache builddep \
    && rm -rf /tmp/*

