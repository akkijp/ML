# Dockerイメージの名前
IMAGE_NAME=akkijp/jupyterlab-cuda

# Dockerfileがあるディレクトリ
DOCKERFILE_DIR=.

# デフォルトのターゲット
.PHONY: all
all: build

# Dockerイメージをビルドするターゲット
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) $(DOCKERFILE_DIR)
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
