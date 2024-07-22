# Single base components (can be cached)

server-base:
	docker build --file server/Dockerfile.server.step1 --tag fractal/server-base:1 .

demos-v1-base:
	docker build --file demos-v1/Dockerfile.demos.step1 --tag fractal/demos-v1-base:1 .

demos-v2-base:
	docker build --file demos-v2/Dockerfile.demos.step1 --tag fractal/demos-v2-base:1 .

web-base:
	docker build --file web/Dockerfile.web.step1 --tag fractal/web-base:1 .

# Single base components (depending on cache or no-cache, they may use
# up-to-date environment variables)

server-no-cache: server-base
	docker compose --file docker-compose-demos.yml build server --no-cache

demos-v1-no-cache:	demos-v1-base
	docker compose --file docker-compose-demos.yml build demos-v1 --no-cache

demos-v2-no-cache:	demos-v2-base
	docker compose --file docker-compose-demos.yml build demos-v2 --no-cache

web-no-cache: web-base
	docker compose --file docker-compose-demos.yml build web --no-cache

# End-to-end runs

run-demos: clean server-no-cache demos-v1-no-cache demos-v2-no-cache web-no-cache
	docker compose --file docker-compose-demos.yml up

# server-base demos-v2-base
run-demos-v2-github: 
	docker compose --file docker-compose-demos.yml up demos-v2 --abort-on-container-exit

# server-base demos-v1-base
run-demos-v1-github: 
	docker compose --file docker-compose-demos.yml up demos-v1 --abort-on-container-exit


# Auxiliary targets

clean:
	docker compose -f docker-compose-demos.yml down -v

list-share:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share
