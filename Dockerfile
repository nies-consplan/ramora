FROM uribo/tiny_rocker_geospatial:latest
MAINTAINER "Shinya Uryu" uryu.shinya@nies.go.jp

RUN apt-get install -y \
  texlive-xetex \
  fonts-ipaexfont

RUN install2.r \
  config docker estatapi ggforce here hrbrthemes \
  liftr jpmesh jpndistrict \
  RefManageR rdrop2

# RUN R -e "devtools::install_github('thomasp85/patchwork')"
