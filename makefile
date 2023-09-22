run:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose up --build --force-recreate

run-demos:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose up --build --force-recreate --file docker-compose-demos.yml

clean:
	docker compose down

clean-all:
	rm -r fractal-db-data
	rm -r fractal-share
