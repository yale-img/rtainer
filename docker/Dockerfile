FROM nvidia/cuda:11.6.1-devel-ubuntu20.04

ARG gid
ARG uid
ARG distro=noetic
ENV ROS_DISTRO=$distro

ENV DEBIAN_FRONTEND noninteractive
ADD scripts /tmp/scripts

RUN /tmp/scripts/system_dependencies.sh

# Replace 1001 with your user / group id
ENV UID=$uid
ENV GID=$gid
RUN mkdir -p /app && \
    echo "app:x:${UID}:${GID}:App,,,:/app:/bin/bash" >> /etc/passwd && \
    echo "app:x:${GID}:" >> /etc/group && \
    echo "app ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/app && \
    chmod 0440 /etc/sudoers.d/app && \
    chown ${UID}:${GID} -R /app

USER app
ENV HOME /app
WORKDIR /app

ENV PATH="/app/.local/bin:${PATH}"
RUN wget https://bootstrap.pypa.io/get-pip.py && \
	python3 get-pip.py --user && rm get-pip.py

RUN /tmp/scripts/python_dependencies.sh

RUN /tmp/ros_setup.sh
