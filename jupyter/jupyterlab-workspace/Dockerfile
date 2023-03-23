FROM akkijp/jupyter-jupyterlab:latest

USER root

########################################################
# Common
########################################################
# パッケージの追加とタイムゾーンの設定
# 必要に応じてインストールするパッケージを追加してください
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
        software-properties-common \
        tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


########################################################
# Custom
########################################################
# この下に、個人用の設定を追加...
# ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y --no-install-recommends install kmod \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Basic
RUN conda install -y -c conda-forge jupyterlab-git nodejs
RUN conda install -y -c huggingface transformers
# RUN conda install -y sentencepiece
