run:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose up --build --force-recreate

run-demos:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose --file docker-compose-demos.yml up --build --force-recreate

clean:
	docker compose down

clean-all:
	rm -rf fractal-db-data
	rm -rf fractal-share
