# Research Container

Easily run code with specific dependencies, such as CUDA or specific python packages, inside of a Docker container.

## Quick Install

Install rtainer directly into your project. `cd` into your project directory and run the following command:

```bash
curl -sSL https://raw.githubusercontent.com/yale-img/rtainer/refs/heads/master/install | bash -s -- .
```

## Install Dependencies

You only need to install dependencies on the host once. If you already have the latest nvidia driver, Docker, and nvidia-docker all installed, you can skip this section.

### Install the latest nvidia driver

Use the `ubuntu-drivers` command.

Remove all existing drivers first, then install the latest drivers like so:

```
sudo apt-get remove --purge '^nvidia-.*'
sudo ubuntu-drivers autoinstall
```

>> Note: It's not necessary to install CUDA or cudnn on the host (but it's also fine if they're already installed), these will be installed in the container.

### Install Docker with nvidia-docker

Install Docker with nvidia-docker on an Ubuntu host by running:

```
curl -L https://gist.githubusercontent.com/nathantsoi/e668e83f8cadfa0b87b67d18cc965bd3/raw/setup_docker.sh | sudo bash
```

## How to Configure

1. Install rtainer into an existing project. 

  `cd` into the existing project directory and run the following command:

	```bash
	curl -sSL https://raw.githubusercontent.com/yale-img/rtainer/main/install | bash -s -- . 
	```
> NOTE: The install script will configure the container name to match the project name. In some cases, such as on a shared machine, it may be necessary to changed the project name so that it does not collide with another project. Do this by editing the file `config/name` in the project directory.

2. Edit the `Dockerfile`, setting the base container on the first line with a tag from: https://hub.docker.com/ and any additional dependencies the project requires. For example:

   - Add or remove Python packages in the pip install commands as needed
   - Add any additional system packages to the apt-get install commands

> NOTE: Whenever possible, lock dependencies, such as pip packages, to specific versions to ensure reproducibility.

3. To change mount points (aka, map a folder on the host to a path in the container), modify the file `config/mounts`.

4. (Optional) To change mapped ports (aka, map a port on the host to a port in the container, as in for tensorboard), modify the file `config/ports`.

  > NOTE: By default, the container will operate on the host network, effectively forwarding all ports from the host to the container. This is useful for running web servers or other services that need to be accessible from outside the container.

## How to Use

1. In the project directory, run `./container build` to build the container.
  - It is only necessary to re-build the container when the container name or the Dockerfile changes.
  - All dependencies are installed in the container via the Dockerfile. If a dependency is needed, add it to the Dockerfile and then run `./container build`. Do _not_ install dependencies directly in the container shell, as these changes will not persist after the container is re-built.
  - Building the container will take a few minutes, but once it is built, it remains cached until the container configuration changes.

> Note: Edit the project name later by changing it in the `config/name` file, and re-build the container (`./container build`).

2. Run `./container start` (optional).
  - The container needs to be started only once after the host computer is turned on or `./container restart` after the container is re-built.
	- The container will be automatically started if it is not running when the next command (`shell`) is run.
  - This step is equivalent to turning on a new container (which is like a virtual machine).

3. Run `./container shell`.
  - The `./container shell` command can be run as many times as needed.
  - Each time it is run, a new terminal in the existing container will be opened.

4. Run `./container shell`
  - Then run `ls` to see the mounted folders and `cd` into the project folder. The project folder is automatically mounted inside the container.
	- Run the project code like normal.

> Note: A terminal running in the container can be identified by a prompt that looks something like: `ntsoi@0457dfe8d098:~$` where `ntsoi` is the current user's username.




