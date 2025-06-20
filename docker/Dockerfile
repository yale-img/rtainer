# =============================================================================
# Base Image and Build Arguments
# =============================================================================
FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04

ARG gid
ARG uid
ARG username

# =============================================================================
# Environment Setup
# =============================================================================
ENV DEBIAN_FRONTEND noninteractive

# =============================================================================
# NVIDIA CUDA Repository Setup
# =============================================================================
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub

# =============================================================================
# System Package Installation
# =============================================================================

RUN apt-get update && apt-get install -y \
  htop \
  git \
  wget \
  sudo \
  vim \
  curl \
  lsb-release \
  python3 \
  python3-pip \
  python3-tk \
  python3-venv \
  python3-opencv

# =============================================================================
# Additional Repository Setup (eg. for Ray)
# =============================================================================
# redis and rsync, for ray
RUN curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

# =============================================================================
# Additional System Packages (eg. Redis and utilities)
# =============================================================================

RUN apt-get update && apt-get install -y \
    redis \
    rsync \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# User Creation and Configuration
# =============================================================================

ENV UID=$uid
ENV GID=$gid
ENV USERNAME=$username
RUN mkdir -p /home/${USERNAME} && \
    echo "${USERNAME}:x:${UID}:${GID}:${USERNAME},,,:/${USERNAME}:/bin/bash" >> /etc/passwd && \
    echo "${USERNAME}:x:${GID}:" >> /etc/group && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    chown ${UID}:${GID} -R /home/${USERNAME} && \
    echo "export PATH=/home/${USERNAME}/.local/bin/:${PATH}" >> /home/${USERNAME}/.bash_profile && \
    echo "export LC_ALL=C.UTF-8" >> /home/${USERNAME}/.bash_profile && \
    echo "export LANG=C.UTF-8" >> /home/${USERNAME}/.bash_profile && \
    echo "cd /home/${USERNAME}/YOUR_PROJECT_NAME" >> /home/${USERNAME}/.bash_profile

# =============================================================================
# Switch to User Context
# =============================================================================

USER $username
ENV HOME /home/$username
WORKDIR /home/$username

# =============================================================================
# Python Package Installation
# =============================================================================

RUN python3 -m pip install --upgrade pip
RUN pip3 install \
  ap_perf \
  torch \
  torchvision \
  torchaudio \
  torchinfo \
  torchmetrics \
  protobuf \
  tensorboard \
  pytest \
  ray[default,tune] \
  aiohttp-cors \
  pandas jupyterlab matplotlib seaborn unzip \
  scikit-learn \
  mmap_ninja \
  tqdm

# =============================================================================
# NumPy Upgrade (separate to ensure compatibility)
# =============================================================================
RUN pip3 install numpy --upgrade
