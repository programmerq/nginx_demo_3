= Nginx demo for my talk

This uses [docker](https://www.docker.com/) and [BATS](https://github.com/sstephenson/bats) to show how to write integration tests for a live nginx server.

# build the container
docker build -t bats .
# launch the container and run the tests
docker run -t -i bats /bin/bash -c 'nginx && bats /nginx.bats'

# all in one shot
docker build -t bats . ; docker run -t -i bats /bin/bash -c 'nginx && bats /nginx.bats'
