FROM rocker/geospatial:latest
MAINTAINER "Shinya Uryu" <uryu.shinya@nies.go.jp>

# Enabled to non-ASCII font (especially Japanese) embed in PDF
RUN apt-get install -y \
  fonts-ipaexfont

RUN install2.r --error \
  config drake here hrbrthemes \
  liftr lwgeom RefManageR rdrop2

RUN installGithub.r \
  'thomasp85/patchwork' \
  'hadley/emo'
