FROM rocker/geospatial:4.0.0@sha256:c18734c684f22a11d61a4ae3d9e7d22e4ab4f1548c748d59f719def0d6c1469e

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
  install2.r --error --repos 'http://mran.revolutionanalytics.com/snapshot/2020-05-26' \
    bench \
    bit64 \
    classInt \
    colormap \
    config \
    conflicted \
    cowplot \
    cptcity \
    data.table \
    drake \
    dtplyr \
    ensurer \
    ggforce \
    here \
    hrbrthemes \
    lwgeom \
    naniar \
    patchwork \
    reprex \
    rnaturalearth \
    roxygen2md \
    scico \
    sf \
    stars \
    tictoc \
    usethis \
    whoami \
    assertr && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN set -x && \
  : "GitHub経由でのパッケージのインストール" && \
  installGithub.r \
    'ropenscilabs/rnaturalearthhires' && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
