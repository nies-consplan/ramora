FROM rocker/geospatial:3.5.2@sha256:7b68c0b2f997e8ad0dc404ff6c319b4ec24c14a239fb8f6acae4af955bee9f4d

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
  : "GitHub経由でのパッケージのインストール" && \
  installGithub.r \
    'thomasp85/gganimate' \ 
    'thomasp85/patchwork' \
    'hadley/emo' \
    'r-lib/roxygen2md' \
    'r-spatial/lwgeom' \
    'r-spatial/sf' \
    'r-spatial/stars' && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
