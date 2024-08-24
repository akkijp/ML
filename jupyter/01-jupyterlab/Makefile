# Dockerイメージの名前
IMAGE_NAME=akkijp/jupyterlab

# BASE_IMAGE_VERSION=v1.7_cuda-12.2_ubuntu-22.04
BASE_IMAGE_VERSION=v1.6_cuda-11.8_ubuntu-22.04

# Dockerfileがあるディレクトリ
DOCKERFILE_DIR=.

# デフォルトのターゲット
.PHONY: all
all: build

# Dockerイメージをビルドするターゲット
.PHONY: build
build:
	docker build --build-arg BASE_IMAGE_VERSION=$(BASE_IMAGE_VERSION) -t $(IMAGE_NAME) $(DOCKERFILE_DIR)
	docker tag $(IMAGE_NAME) $(IMAGE_NAME):$(shell date +%Y%m%d-%H%M%S)

# Dockerコンテナを実行するターゲット
.PHONY: run
run:
	docker run -it --rm $(IMAGE_NAME)

# Dockerイメージを削除するターゲット
.PHONY: clean
clean:
	docker rmi $(IMAGE_NAME)

# Dockerイメージの情報を表示するターゲット
.PHONY: info
info:
	docker images | grep $(IMAGE_NAME)

# Dockerイメージをプッシュするターゲット
.PHONY: push
push:
	docker push $(IMAGE_NAME):latest
