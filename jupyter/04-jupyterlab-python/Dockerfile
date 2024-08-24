# Use the build argument in the FROM statement
FROM akkijp/jupyterlab-cuda


RUN conda create -n py39 python=3.9 jupyterlab && \
    conda create -n py310 python=3.10 jupyterlab && \
    conda update conda && \
    conda update --all

RUN /bin/bash -c "\
    source activate py39 && \
    ipython kernel install --user --name=py39 --display-name=py39 && \
    source activate py310 && \
    ipython kernel install --user --name=py310 --display-name=py310"
