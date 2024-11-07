# wordpress_woocommerce_docker_setup

env.example to .env
`cp .env.example .env`

Change the `COMPOSE_PROJECT_NAME` if nessasary.
Change the `WOOCOMMERCE_VERSION` if nessasary.

Check the rest of the settings if apply to your machine.

`docker compose up -d` to build the docker image. wait atleast 30 seconds for the entry-point.sh to do its thing.


For the reinstallation of a new woocommerce version the best thing you can do is: 
`docker compose down`
`docker volume prune -a` 
`docker image prune -a`

and then: 
`docker compose up -d --build`






