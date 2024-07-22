FROM cschranz/gpu-jupyter:v1.7_cuda-12.2_ubuntu-22.04

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
        torch \
        requests \
        torchsummary \
        torchinfo \
        wandb


# docker install
COPY docker_install.sh /tmp/
RUN /tmp/docker_install.sh



# Basic
# RUN conda install -y -c conda-forge jupyterlab-git nodejs
# RUN conda install -y -c huggingface transformers
# RUN conda install -y sentencepiece

########################################################
# python 3.9 環境作成 (未完成)
########################################################
# RUN source ~/.bashrc \
#     && conda init bash \
#     && conda create -n py39 python=3.9 jupyterlab

# SHELL ["/bin/bash", "-l", "-c"]
# RUN conda init bash \
#     && conda activate py39
# RUN pip install ipykernel

# # Install PyTorch with dependencies
# RUN conda install --quiet --yes \
#     pyyaml mkl mkl-include setuptools cmake cffi typing && \
#     conda clean --all -f -y

# RUN set -ex \
#  && buildDeps=' \
#     torch==1.13.1 \
#     torchvision==0.14.1 \
#     torchaudio==0.13.1 \
#     torchviz==0.0.2 \
# ' \
#  && pip install --no-cache-dir torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118

# RUN ipython kernel install --user --name=py39

# ########################################################
# # change to default
# ########################################################
# change jovyan
# RUN chown -R "${NB_USER}:${NB_GID}" "/home/${NB_USER}"
# SHELL ["/bin/sh", "-c"]
# USER ${NB_UID}
# RUN conda activate base
