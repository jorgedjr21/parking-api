# PARKING API

## How to install

 **Requiriments** 
 - Docker
 - docker-compose (optional)
 - PostgreSQL runing in some server (local or web)

1 - You can pull the image of the docker hub:

```shell
# THE ENV VARS DB_HOST, DB_USER and DB_PASWORD need to be set with your local configuration
docker run --name parking_api --network=parking-api_default -p 3000:3000 -e "DB_HOST=parking-api_db_1" -e "DB_USER=postgres" -e "DB_PASSWORD=postgres" jorgedjr21/parking_api:latest 

docker exec -it parking_api rails db:migrate # IF necessary
```

or

2 - Optionally you can download the latest release version

**[Releases](https://github.com/jorgedjr21/parking-api/releases)** <- Dowload here

After download, unpack the files, and run, inside the project folder:

```sh
  docker-compose build .
  docker-compose up
```

  **In other console**

```sh
  docker-compose run --rm web rails db:migrate #If necessary
```

## Tests and Coverage

- The actual coverage of the application is **100%**
- The CI/CD was made with [Github Actions](https://github.com/jorgedjr21/parking-api/actions?query=workflow%3A%22Parking+API%22))
  - When a push is made in the **master** branch, the github action auto push to dockerhub with the tag *latest*

### Other Infos

You can find the docker hub repository of this repo here:

https://hub.docker.com/repository/docker/jorgedjr21/parking_api
