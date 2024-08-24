
build:
	cd 01-jupyterlab && make build && cd -
	cd 02-jupyterlab-nginx && make build && cd -
	cd 03-jupyterlab-cuda && make build && cd -
	cd 04-jupyterlab-python && make build && cd -

up:
	docker compose up

push:
	cd 01-jupyterlab && make push && cd -
	cd 02-jupyterlab-nginx && make push && cd -
	cd 03-jupyterlab-cuda && make push && cd -
	cd 04-jupyterlab-python && make push && cd -
