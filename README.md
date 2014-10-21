# Nginx Testing demo for my talk

This uses [docker](https://www.docker.com/) and [BATS](https://github.com/sstephenson/bats) to show how to write integration tests for a live nginx server.

You need to have docker installed for this to work. If you are not on linux, boot2docker will get you a docker VM that allows this to be run.

If you are using boot2docker, make sure you have run `boot2docker up` and exported the appropriate `DOCKER_HOST` variable.

    # build the container
    docker build -t bats .
    # launch the container and run the tests
    docker run -t -i bats /bin/bash -c 'nginx && bats /nginx.bats'

    # all in one shot
    docker build -t bats . ; docker run -t -i bats /bin/bash -c 'nginx && bats /nginx.bats'
