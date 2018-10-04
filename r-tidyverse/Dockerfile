FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.license="LGPL-3.0" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/REDUS-IMR/fishdocker" \
      org.label-schema.vendor="REDUS Project at IMR Norway"

ARG FS_VERSION=${FS_VERSION:-1.2.6}

RUN apk add --no-cache R \
	R-doc \
	ttf-liberation \
	libxml2 \
    && apk add --no-cache --virtual makedep R-dev \
	linux-headers \
	curl \
	g++ \
	build-base \
	automake \
	autoconf \
	libxml2-dev \
	libc-dev \
	file \
    # fs package needs a special treatment before compilation
    && cd /tmp \
    && curl -O https://codeload.github.com/r-lib/fs/tar.gz/v${FS_VERSION} \
    && tar -zxf v${FS_VERSION} \
    && { echo -n "#include <uv.h>"; cat fs-${FS_VERSION}/src/RcppExports.cpp; } > fs-${FS_VERSION}/src/RcppExports.cpp.new \
    && mv fs-${FS_VERSION}/src/RcppExports.cpp.new fs-1.2.6/src/RcppExports.cpp \
    && cd fs-${FS_VERSION}/src/libuv \
    && ls \
    && aclocal \
    && automake \
    && autoconf \
    # Install Rcpp
    && echo "options(repos = c(CRAN = 'https://cloud.r-project.org/'), download.file.method = 'libcurl')" >> /usr/lib/R/etc/Rprofile.site \
    && Rscript -e 'install.packages("Rcpp")' \
    # Install fs package from source
    && R CMD INSTALL /tmp/fs-1.2.6 \
    # Install tidyverse packages
    && Rscript -e 'install.packages("tidyverse")' \
    # Cleaning up...
    && apk del --no-cache makedep \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

