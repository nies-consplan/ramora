FROM uribo/tiny_rocker_geospatial:latest
MAINTAINER "Shinya Uryu" uryu.shinya@nies.go.jp

RUN apt-get install -y \
  texlive-xetex \
  fonts-ipaexfont

RUN install2.r \
  config docker estatapi jpmesh jpndistrict \
  RefManageR
