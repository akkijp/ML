# Use the build argument in the FROM statement
FROM akkijp/jupyterlab-nginx

USER root

# https://note.com/ngc_shj/n/nfba1821d3328
# https://qiita.com/tf63/items/0c6da72fe749319423b4

########################################################
# Register NVIDIA software repository
########################################################
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        zlib1g \
        ubuntu-drivers-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb
RUN add-apt-repository ppa:graphics-drivers/ppa


########################################################
# CUDA 11
########################################################
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        cuda-11-8 \
        cudnn-cuda-11 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ENV CUDA_PATH="/usr/local/cuda-11.8"
ENV PATH="/usr/local/cuda-11.8/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda-11.8/lib64:${LD_LIBRARY_PATH}"



########################################################
# CUDA 12
########################################################
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        cuda-12-6 \
        cudnn-cuda-12 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ENV CUDA_PATH="/usr/local/cuda-12.6"
ENV PATH="/usr/local/cuda-12.6/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda-12.6/lib64:${LD_LIBRARY_PATH}"



########################################################
# NVIDIA driver
########################################################
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        nvidia-driver-550 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN update-alternatives --install /usr/local/cuda cuda /usr/local/cuda-12.6 100

########################################################
# Cleanup
########################################################
# この下に、個人用の設定を追加...
# ARG DEBIAN_FRONTEND=noninteractive

# change jovyan
USER ${NB_UID}
