run:
	mkdir -p fractal-data/
	docker compose up --build
clean:
	docker compose down
