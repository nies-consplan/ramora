FROM uribo/tiny_rocker_geospatial:latest
MAINTAINER "Shinya Uryu" uryu.shinya@nies.go.jp

RUN apt-get install -y \
  texlive-xetex \
  fonts-ipaexfont

RUN install2.r \
  config docker estatapi ggforce hrbrthemes jpmesh jpndistrict \
  RefManageR

# RUN R -e "devtools::install_github('Robinlovelace/geocompr')"
