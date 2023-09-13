run:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose up --build --force-recreate

clean:
	docker compose down

clean-all:
	rm -r fractal-db-data
	rm -r fractal-share
