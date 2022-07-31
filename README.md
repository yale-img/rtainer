# Research Container

Easily run code with CUDA dependencies inside of a Docker container.

## Setup

You only need to do this on the host once. If you already have the latest nvidia driver, Docker, and nvidia-docker all installed, you can skip this section.

### Install the latest nvidia driver

I like to use the `ubuntu-drivers` command.

Remove all existing drivers first, then install the latest drivers like so:

```
sudo apt-get remove --purge '^nvidia-.*'
sudo ubuntu-drivers autoinstall
```

>> Note: You don't need to install CUDA or cudnn on the host (but it's also fine if they're already installed), these will be installed in the container.

### Install Docker with nvidia-docker

Install Docker with nvidia-docker on an Ubuntu host by running:

```
curl -L https://gist.githubusercontent.com/nathantsoi/e668e83f8cadfa0b87b67d18cc965bd3/raw/setup_docker.sh | sudo bash
```

### (Optional) Automatic Image Pruning

To enable monthly image pruning, run:

```
sudo cp cron/docker_prune /etc/cron.monthly/docker_prune
```

## How to Configure

1. Install the code
	- If you're starting a new project, fork this repository and then place your source code anywhere in the forked project.
		- `cd` into the forked repository directory
	- If you want to add rtainer to an existing project, you can simply clone this repository and run `./install [path to existing project]`.
		- `cd` into the existing project directory


2. Edit the first line of the `Dockerfile`, setting the base container with a tag from: https://hub.docker.com/r/nvidia/cuda/tags

3. To install system-level packages (aka, via `apt`), modify the file `scripts/system_dependencies.sh`

4. To install python packages (aka, via `pip`), modify the file `scripts/python_dependencies.sh`

5. To change mount points (aka, map a folder on the host to a path in the container), modify the file `config/mounts`.

6. To change mapped ports (aka, map a port on the host to a portin the container, as in for tensorboard), modify the file `config/ports`.

## How to Run

1. Run `./container build projectname` where `projectname` is a unique name to use for the container.
  - Note that `projectname` is not required if you ran `install`. The `projectname` is set to the folder of your project by default.
	- If you did not run `install`, you only need to specify `projectname` the first time the command is run. It is saved on subsequent runs.
  - You only need to re-build the container when the container name or installed dependencies change.- All dependencies should be installed in the container, you shouldn't run `apt` or `pip` inside the container later. So, if you want to add a dependency, you should add it to the appropriate file in `scripts/` and then run `./container build`.
  - Building the container will take a few minutes, but once it is built, it remains cached until the container configuration changes.

>> Note: you can edit the project name later by changing it in the `config/name` file, but you'll need to re-build the container.

2. Run `./container start` (optional).
  - The container needs to be started only once after your computer is turned on or `./container restart` after the container is re-built.
	- The container will be automatically started if it is not running when you run the next command (`shell`).
  - This step is equivalent to turning on your new container (which is like a virtual machine).

3. Run `./container shell`.
  - The `./container shell` command can be run as many times as you want.
  - Each time you run it, a new terminal in the container will be opened.

4. Run `./container shell`
  - Then run `ls` to see the mounted folders and `cd` into your project folder. The project folder is automatically mounted inside the container.
	- Run your code like normal.

>> Note: you'll know that you're in the container when your prompt looks something like: `ntsoi@0457dfe8d098:~$` where `ntsoi` is my username.




