FROM uribo/tiny_rocker_geospatial:latest
MAINTAINER "Shinya Uryu" uryu.shinya@nies.go.jp

RUN install2.r
  config estatapi jpmesh jpndistrict
