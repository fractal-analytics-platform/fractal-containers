run:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose up --build --force-recreate

run-demos:
	docker compose --file docker-compose-demos.yml up --build --force-recreate

run-demos-github:
	docker compose --file docker-compose-demos.yml up demos --build --force-recreate --abort-on-container-exit

clean:
	docker compose -f docker-compose-demos.yml down -v

clean-all:
	rm -rf fractal-db-data
	rm -rf fractal-share

list-share:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share
