FROM ubuntu:focal

LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.source="https://github.com/rocker-org/rocker-versioned2" \
      org.opencontainers.image.vendor="Rocker Project" \
      org.opencontainers.image.authors="Carl Boettiger <cboettig@ropensci.org>"

ENV R_VERSION=4.1.1
ENV TERM=xterm
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV R_HOME=/usr/local/lib/R
ENV CRAN=https://packagemanager.rstudio.com/cran/2021-09-22+MTo1MTg0MzM5O0Q4MjI2M0Y
ENV TZ=Etc/UTC

COPY scripts /rocker_scripts

RUN /rocker_scripts/r-4.1.1.sh

# Start from OpenAnalytics - modified

# packages needed for basic shiny functionality
# install shinyproxy package with demo shiny application
COPY shinyproxy/shinyproxy_0.0.1.tar.gz /root/


RUN apt-get update && apt-get install -y libz-dev     libzmq3-dev

RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='${CRAN}')"

RUN R CMD INSTALL /root/shinyproxy_0.0.1.tar.gz

RUN rm /root/shinyproxy_0.0.1.tar.gz

#RUN cp /usr/local/lib/R/etc/Rprofile.site /usr/local/lib/R/etc/Rprofile.site.original

# set host and port
COPY shinyproxy/Rprofile.site /usr/local/lib/R/etc/
# END from OpenAnalytics - modified

#CMD ["R"]

CMD ["sleep", "infinity"]