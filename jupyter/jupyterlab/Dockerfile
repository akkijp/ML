FROM jupyter/datascience-notebook:ubuntu-20.04 as base

# 参考: https://qiita.com/taiyodayo/items/76f702b5facb9beca5e5
# 参考: https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/12.0.1/ubuntu2204/base/Dockerfile
USER root
ENV OS ubuntu2004

########################################################
# Common
########################################################
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    gnupg \
    vim && \
    apt-get purge --autoremove && \
    sudo apt upgrade -y && \
    rm -rf /var/lib/apt/lists/*


########################################################
# Instann CUDA
########################################################
# Copyright (c) NVIDIA CORPORATION. All rights reserved.
FROM base as base-amd64

ENV NVARCH x86_64

ENV NVIDIA_REQUIRE_CUDA "cuda>=11.6 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=450,driver<451 brand=tesla,driver>=470,driver<471 brand=unknown,driver>=470,driver<471 brand=nvidia,driver>=470,driver<471 brand=nvidiartx,driver>=470,driver<471 brand=geforce,driver>=470,driver<471 brand=geforcertx,driver>=470,driver<471 brand=quadro,driver>=470,driver<471 brand=quadrortx,driver>=470,driver<471 brand=titan,driver>=470,driver<471 brand=titanrtx,driver>=470,driver<471"
ENV NV_CUDA_CUDART_VERSION 11.6.55-1
ENV NV_CUDA_COMPAT_PACKAGE cuda-compat-11-6

FROM base as base-arm64

ENV NVARCH sbsa
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.6"
ENV NV_CUDA_CUDART_VERSION 11.6.55-1

FROM base-${TARGETARCH}

ARG TARGETARCH

LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/${OS}/${NVARCH}/3bf863cc.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/${OS}/${NVARCH} /" > /etc/apt/sources.list.d/cuda.list && \
    apt-get purge --autoremove -y curl \
    && rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 11.6.2

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-11-6=${NV_CUDA_CUDART_VERSION} \
    ${NV_CUDA_COMPAT_PACKAGE} \
    && rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
    && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# COPY NGC-DL-CONTAINER-LICENSE /

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility




########################################################
# Instann CUDNN
########################################################
FROM base as base-amd64

ENV NV_CUDNN_VERSION 8.4.0.27
ENV NV_CUDNN_PACKAGE_NAME "libcudnn8"

ENV NV_CUDNN_PACKAGE "libcudnn8=$NV_CUDNN_VERSION-1+cuda11.6"
ENV NV_CUDNN_PACKAGE_DEV "libcudnn8-dev=$NV_CUDNN_VERSION-1+cuda11.6"

FROM base-${TARGETARCH}

ARG TARGETARCH

LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"
LABEL com.nvidia.cudnn.version="${NV_CUDNN_VERSION}"

# 参考 https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html
# Package Manager Installation
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/cuda-${OS}.pin && \ 
    mv cuda-${OS}.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \ 
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/3bf863cc.pub && \ 
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/ /"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ${NV_CUDNN_PACKAGE} \
    ${NV_CUDNN_PACKAGE_DEV} \
    && apt-mark hold ${NV_CUDNN_PACKAGE_NAME} \
    && rm -rf /var/lib/apt/lists/*

USER jovyan



########################################################
# Custom
########################################################
# この下に、個人用の設定を追加...
ARG DEBIAN_FRONTEND=noninteractive
USER root

# Basic
RUN conda install -y -c conda-forge jupyterlab-git nodejs
RUN conda install -y transformers sentencepiece

# CUDA 11.6用
# https://pytorch.org/get-started/locally/
RUN conda install pytorch torchvision torchaudio pytorch-cuda=11.6 -c pytorch -c nvidia

# # パッケージの追加とタイムゾーンの設定
# # 必要に応じてインストールするパッケージを追加してください
RUN sudo apt-get update
RUN sudo apt-get install -y \
    tzdata \
&&  ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

# # JupyterLab関連のパッケージ（いくつかの拡張機能を含む）
# # 必要に応じて、JupyterLabの拡張機能などを追加してください
# RUN python3 -m pip install --upgrade pip \
# &&  pip install --no-cache-dir \
#     black \
#     jupyterlab \
#     jupyterlab_code_formatter \
#     jupyterlab-git \
#     lckr-jupyterlab-variableinspector \
#     jupyterlab_widgets \
#     ipywidgets \
#     import-ipynb

# # 基本パッケージ
# # Pythonでよく利用する基本的なパッケージです
# # JupyterLabの動作には影響しないので、必要に応じてカスタマイズしてください
# RUN pip install --no-cache-dir \
#     numpy \
#     pandas \
#     scipy \
#     scikit-learn \
#     pycaret \
#     matplotlib \
#     japanize_matplotlib \
#     mlxtend \
#     seaborn \
#     plotly \
#     requests \
#     beautifulsoup4 \
#     Pillow \
#     opencv-python

# # 追加パッケージ（必要に応じて）
# # 各環境に特化したパッケージがある場合、この部分に追加します
# RUN pip install --no-cache-dir \
#     pydeps \
#     graphviz \
#     pandas_profiling \
#     shap \
#     umap \
#     xgboost \
#     lightgbm

USER jovyan

ENV TZ=Asia/Tokyo
EXPOSE 8888
