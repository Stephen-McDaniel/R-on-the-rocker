FROM yakdata/verse-r-4.1.1

LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.source="https://github.com/rocker-org/rocker-versioned2" \
      org.opencontainers.image.vendor="Rocker Project" \
      org.opencontainers.image.authors="Carl Boettiger <cboettig@ropensci.org>"

ENV S6_VERSION=v2.1.0.2
ENV RSTUDIO_VERSION=1.4.1717
ENV PATH=/usr/lib/rstudio-server/bin:$PATH

COPY scripts /rocker_scripts

RUN /rocker_scripts/rstudio-verse-r-4.1.1.sh
RUN /rocker_scripts/install_pandoc.sh

RUN chmod -R 777 /etc/rstudio && \
    /rocker_scripts/no_auth.sh && \
    chmod -R 744 /etc/rstudio

EXPOSE 8787

CMD ["/init"]



