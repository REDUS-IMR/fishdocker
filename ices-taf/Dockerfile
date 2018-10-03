FROM redusimr/r-tidyverse:latest

RUN apk add --no-cache gcompat \
    && Rscript -e 'install.packages("icesTAF")' \
	-e 'install.packages("areaplot")' \
    && rm -rf /tmp/*

