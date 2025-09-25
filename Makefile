dev:
	docker compose up pixelfoster-dev

build:
	docker compose run --rm pixelfoster-build

clean:
	rm -rf public/* public-dev/*