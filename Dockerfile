FROM rocker/geospatial:3.5.1@sha256:0552a064a1dd334c6b273c2e7c7df4614555d0dcdd3fc3b6710fb6eb8e1b8d3f

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
    python3-pip && \
  apt-get clean && \
  : "日本語のロケールを有効にする" && \
  localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
  rm -rf /var/lib/apt/lists/*
  
RUN set -x && \
  : "rust environment" && \
  curl -sf -L https://static.rust-lang.org/rustup.sh | sh && \
  git clone https://github.com/rust-lang/cargo && \
  cd cargo && \
  cargo build --release && \
  cargo install gifski

RUN set -x && \
  : "CRAN経由でのパッケージのインストール" && \
  install2.r --error \
    colormap \
    config \
    conflicted \
    ensurer \ 
    ggforce \
    keyring \
    here \
    hrbrthemes \
    lwgeom \
    naniar \
    RefManageR \
    rdrop2 \
    scico \
    skimr \
    shinyjs \
    usethis \
    whoami \
    assertr \
    imager \
    keras \
    vdiffr \
    sealr && \
  : "GitHub経由でのパッケージのインストール" && \
  installGithub.r \
    'thomasp85/gganimate' \ 
    'thomasp85/patchwork' \
    'hadley/emo' \
    'tidyverse/reprex' \
    'r-lib/roxygen2md' \
    'ropensci/drake' \
    'r-spatial/stars' && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
