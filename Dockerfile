FROM rocker/geospatial:latest

# Enabled to non-ASCII font (especially Japanese) embed in PDF
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    fonts-ipaexfont \
    libpython3.5 \
    python3-pip && \
  : "日本語のロケールを有効にする" && \
  localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
  rm -rf /var/lib/apt/lists/*

RUN set -x && \
  : "CRAN経由でのパッケージのインストール" && \
  install2.r --error \
    config \
    conflicted \
    drake \
    ggforce \
    here \
    hrbrthemes \
    liftr \
    lwgeom \
    naniar \
    RefManageR \
    rdrop2 \
    skimr \
    shinyjs \
    usethis \
    whoami \
    assertr \
    imager \
    keras \
    sealr && \
  : "GitHub経由でのパッケージのインストール" && \
  installGithub.r \
    'thomasp85/patchwork' \
    'hadley/emo' \
    'tidyverse/reprex' \
    'r-lib/roxygen2md'
