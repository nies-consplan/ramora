FROM rocker/geospatial:4.0.2@sha256:d35e50e7191d376edb501bb040f130991335d5549419e664520fc42ee86f845d

# Enabled to non-ASCII font (especially Japanese) embed in PDF
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    cmake \
    curl \ 
    fonts-ipaexfont \
    libmagick++-dev \
    libsecret-1-dev \
    libsodium-dev \
    libssl-dev \
    libzmq3-dev \
    imagemagick \
    libpython3.5 \
    python3-dev \
    python3-setuptools \
    python3-pip \
    unar && \
  apt-get install -y \
    r-cran-bit64 \
    r-cran-data.table \
    r-cran-ggforce \
    r-cran-lwgeom \
    r-cran-reprex \
    r-cran-sf \
    r-cran-usethis && \
  apt-get clean && \
  : "日本語のロケールを有効にする" && \
  localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
  rm -rf /var/lib/apt/lists/*

RUN set -x && \
  : "rust environment" && \
  curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN set -x && \
  ~/.cargo/bin/cargo install gifski
  
ARG GITHUB_PAT

RUN set -x && \
  echo "GITHUB_PAT=$GITHUB_PAT" >> /usr/local/lib/R/etc/Renviron

RUN set -x && \
  : "CRAN経由でのパッケージのインストール" && \
  install2.r --error --ncpus -1 --repos 'https://mran.revolutionanalytics.com/snapshot/2020-10-07' \
    assertr \
    bench \
    classInt \
    colormap \
    config \
    conflicted \
    cowplot \
    cptcity \
    drake \
    dtplyr \
    ensurer \
    gganimate \
    here \
    hrbrthemes \
    naniar \
    patchwork \
    rdrop2 \
    rnaturalearth \
    roxygen2md \
    scico \
    tictoc \
    whoami && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN set -x && \
  : "GitHub経由でのパッケージのインストール" && \
  installGithub.r \
    'ropenscilabs/rnaturalearthhires' && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
