FROM rocker/geospatial:latest
MAINTAINER "Shinya Uryu" <uryu.shinya@nies.go.jp>

# For knitr pdf output
RUN apt-get install -y \
  texlive-latex-base \
  texlive-fonts-recommended \
  texlive-fonts-extra

# For JP
RUN apt-get install -y \
  texlive-xetex \
  fonts-ipaexfont

RUN install2.r \
  config drake here hrbrthemes \
  liftr lwgeom RefManageR rdrop2

RUN installGithub.r \
  'thomasp85/patchwork' \
  'hadley/emo'
