FROM rocker/geospatial:latest
MAINTAINER "Shinya Uryu" <uryu.shinya@nies.go.jp>

# Enabled to non-ASCII font (especially Japanese) embed in PDF
RUN apt-get install -y \
  fonts-ipaexfont

RUN install2.r --error \
  config drake ggforce here hrbrthemes \
  liftr lwgeom naniar RefManageR rdrop2 \
  skimr shinyjs usethis

RUN installGithub.r \
  'thomasp85/patchwork' \
  'hadley/emo' \
  'tidyverse/reprex'
