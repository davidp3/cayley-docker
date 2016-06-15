This repo is heavily influenced by the outdated code in [this repo](https://github.com/saidimu/cayley-docker).

## cayley-docker

This is a Docker image for [Cayley](https://github.com/google/cayley), an open-source graph database.

## Usage

1. Install [Docker](https://www.docker.com/) (for example, the Docker Toolbox) on your host machine if you haven't already.

2. Create a Docker data volume to hold the persistent boltdb data storage.

```sh
docker volume create --name data_volume
```

3. Run Cayley in Docker.

```sh
docker run -v data_volume:/data -p 64321:64321 -d docker.io/davidp3/cayley:0.4.1
```

Then open `http://127.0.0.1:64210` from your browser to access the graph's web GUI.

## Backup/Restore the Bolt Database

1. To create a backup of the Docker data volume, stored in the current folder as backup.tar.gz:

```sh
docker run --rm -v data_volume:/src -v $PWD:/dst ubuntu bash -c "tar zcvf /dst/backup.tar.gz /src"
```

2. To restore the backup to a new volume (also named data_volume by the `docker volume create` call):

```sh
docker run --rm -v data_volume:/dst -v $PWD:/src ubuntu bash -c "cd /dst && tar zxvf /src/backup.tar.gz --strip 1"
```
