FROM rocker/geospatial:latest

# Enabled to non-ASCII font (especially Japanese) embed in PDF
RUN apt-get update && apt-get install -y --no-install-recommends \
  fonts-ipaexfont \
  libpython3.5 \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

RUN install2.r --error \
  config drake ggforce here hrbrthemes \
  liftr lwgeom naniar RefManageR rdrop2 \
  skimr shinyjs usethis whoami \
  assertr \
  imager \
  keras \
  sealr

RUN installGithub.r \
  'thomasp85/patchwork' \
  'hadley/emo' \
  'tidyverse/reprex' \
  'r-lib/roxygen2md'
