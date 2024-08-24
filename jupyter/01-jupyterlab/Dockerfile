# Define a build argument with a default value
ARG BASE_IMAGE_VERSION=v1.7_cuda-12.2_ubuntu-22.04

# Use the build argument in the FROM statement
FROM cschranz/gpu-jupyter:${BASE_IMAGE_VERSION}

USER root

# https://y-ni-shi.hatenablog.com/entry/2022/01/03/135000
# SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

########################################################
# Common
########################################################
# パッケージの追加とタイムゾーンの設定
# 必要に応じてインストールするパッケージを追加してください

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
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
    && apt-get -y --no-install-recommends install \
        kmod \
        libopenmpi-dev \
        tzdata \
        git-lfs \
        portaudio19-dev \
        python3-pyaudio \
        curl \
        wget \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && tar xzvf ta-lib-0.4.0-src.tar.gz \
    && cd ta-lib && ./configure --prefix=/usr && make && sudo make install && cd - && pip install ta-lib

# sudo権限を付与
RUN usermod -aG sudo ${NB_USER}
RUN echo "${NB_USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# change jovyan
USER ${NB_UID}

RUN pip install --upgrade \
        IPython \
        pandas \
        matplotlib \
        numpy \
        plotly \
        nbformat \
        ipykernel \
        mplfinance \
        scikit-learn \
        lightgbm \
        optuna \
        shap \
        requests \
        wandb \
        huggingface_hub[cli]

RUN pip install --upgrade \
        torch==2.3 \
        torchvision==0.18 \
        torchsummary \
        torchinfo \
        torchtune \
        lm_eval==0.4.*

RUN conda update conda \
    && conda update --all

# docker install
COPY docker_install.sh /tmp/
RUN /tmp/docker_install.sh
