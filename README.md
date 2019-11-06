# README

Setup environment 
1. install docker and setup docker
2. clone fast-salary 
3. cd fast-salary
4. run the docker-composer
```
docker-composer build            # init the image 
docker-composer up               # run docker image
docker-composer up -d            # run docker image by deamon
docker-composer ps               # list the dokcer volume
docker-composer exec web bash    # go to inside volume web
```
5. after up the docker, go to browser and enter: localhost:4000
