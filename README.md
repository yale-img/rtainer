# Research Container

Easily run code with CUDA dependencies inside of a Docker container.

## Setup

You only need to do this on the host once. If you already have Docker with nvidia-docker, skip this section.

Install Docker with nvidia-docker on an Ubuntu host by running:

```
curl -L https://gist.githubusercontent.com/nathantsoi/e668e83f8cadfa0b87b67d18cc965bd3/raw/setup_docker.sh | sudo bash
```

## How to Configure

1. Fork this repository.

2. Edit the first line of the `Dockerfile`, setting the base container with a tag from: https://hub.docker.com/r/nvidia/cuda/tags

3. To install system-level packages (aka, via `apt`), modify the file `scripts/system_dependencies.sh`

4. To install python packages (aka, via `pip`), modify the file `scripts/python_dependencies.sh`

5. To change mount points (aka, map a folder on the host to a path in the container), modify the file `config/mounts`.

6. To change mapped ports (aka, map a port on the host to a portin the container, as in for tensorboard), modify the file `config/ports`.

## How to Run

1. Run `./container build projectname` where projectname is a unique name to use for the container.

2. Run `./container start` 

3. Run `./container shell` every time you want to open a shell inside your new container. Inside a `./container shell`, run your code!




