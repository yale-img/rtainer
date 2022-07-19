#!/bin/bash

set -e
set -x

apt-get update && apt-get install -y \
	python3-opencv ca-certificates python3-dev git wget sudo  \
	cmake ninja-build protobuf-compiler libprotobuf-dev && \
  rm -rf /var/lib/apt/lists/*
ln -sv /usr/bin/python3 /usr/bin/python

apt-get update && apt-get install -y \
    wget \
    sudo \
    vim \
    cm-super \
    texlive \
    texlive-latex-extra \
    texlive-fonts-recommended \
    dvipng

