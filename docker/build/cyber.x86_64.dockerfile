#ARG BASE_IMAGE=nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
ARG BASE_IMAGE=ubuntu:18.04
ARG GEOLOC
FROM ${BASE_IMAGE}

LABEL version="1.2"

ENV DEBIAN_FRONTEND=noninteractive

COPY installers /tmp/installers

RUN bash /tmp/installers/install_minimal_environment.sh "${GEOLOC}"
RUN bash /tmp/installers/install_cyber_dependencies.sh
RUN bash /tmp/installers/install_cmake.sh

# Pre-downloaded tarballs
COPY archive /tmp/archive

RUN bash /tmp/installers/install_bazel.sh
RUN bash /tmp/installers/install_protobuf.sh
RUN bash /tmp/installers/install_qt.sh
RUN bash /tmp/installers/install_fast-rtps.sh
RUN bash /tmp/installers/install_user.sh
RUN bash /tmp/installers/post_install.sh
#RUN bash /tmp/installers/install_pcl.sh

WORKDIR /apollo
USER apollo
