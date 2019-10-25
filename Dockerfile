FROM rocker/geospatial:3.6.1@sha256:f7699b4c7be9b5a358c04877d2b994a6c36fbb41b4fb83512e04a9c4925a20d4

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
    libv8-3.14-dev \
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
  install2.r --error \
    bench \
    citr \
    colormap \
    config \
    conflicted \
    cptcity \
    drake \
    ensurer \
    ggforce \
    keyring \
    here \
    hrbrthemes \
    janitor \
    naniar \
    RefManageR \
    rdrop2 \
    reprex \
    rnaturalearth \
    roxygen2md \
    scico \
    skimr \
    shinyjs \
    tictoc \
    usethis \
    whoami \
    assertr \
    imager \
    keras \
    vdiffr \
    visNetwork && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN set -x && \
  : "GitHub経由でのパッケージのインストール" && \
  installGithub.r \
    'thomasp85/gganimate' \ 
    'thomasp85/patchwork' \
    'hadley/emo' \
    'tidyverse/dtplyr' \
    'r-spatial/classInt' \
    'r-spatial/lwgeom' \
    'r-spatial/sf' \
    'r-spatial/stars' \
    'ropenscilabs/rnaturalearthhires' && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
