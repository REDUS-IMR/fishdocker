FROM redusimr/r-tidyverse:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.license="LGPL-3.0" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/REDUS-IMR/fishdocker" \
      org.label-schema.vendor="REDUS Project at IMR Norway"

RUN apk add --no-cache gcompat \
    && Rscript -e 'install.packages("icesTAF")' \
	-e 'install.packages("areaplot")' \
    && rm -rf /tmp/*

