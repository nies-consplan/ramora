FROM rocker/geospatial:3.6.2@sha256:fa56afb1358977723949f4527220491cccffb87f8cc47e8dd0f4b7467f41bf03

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
  install2.r --error --skipinstalled --repos 'http://mran.revolutionanalytics.com/snapshot/2019-12-09' \
    bench \
    citr \
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
    ggforce \
    keyring \
    here \
    hrbrthemes \
    janitor \
    lwgeom \
    naniar \
    patchwork \
    RefManageR \
    rdrop2 \
    reprex \
    rnaturalearth \
    roxygen2md \
    scico \
    sf \
    skimr \
    shinyjs \
    stars \
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
    'hadley/emo' \
    'ropenscilabs/rnaturalearthhires' && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
