FROM nvidia/cuda:11.6.1-devel-ubuntu20.04

ARG gid
ARG uid
ARG username

ENV DEBIAN_FRONTEND noninteractive
ADD scripts /tmp/scripts

RUN /tmp/scripts/system_dependencies.sh

# Replace 1001 with your user / group id
ENV UID=$uid
ENV GID=$gid
ENV USERNAME=$username
RUN mkdir -p /home/${USERNAME} && \
    echo "${USERNAME}:x:${UID}:${GID}:${USERNAME},,,:/${USERNAME}:/bin/bash" >> /etc/passwd && \
    echo "${USERNAME}:x:${GID}:" >> /etc/group && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    chown ${UID}:${GID} -R /home/${USERNAME}

USER $username
ENV HOME /home/$username
WORKDIR /home/$username

ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"
RUN wget https://bootstrap.pypa.io/get-pip.py && \
	python3 get-pip.py --user && rm get-pip.py

RUN /tmp/scripts/python_dependencies.sh

# Optional
RUN /tmp/scripts/ros_setup.sh
