FROM akkijp/jupyterlab

########################################################
# Nginx
########################################################
# change jovyan
USER root

RUN apt-get update \
    && apt-get -y --no-install-recommends install nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ADD default.conf /etc/nginx/conf.d
ADD ssl /etc/nginx/ssl

# SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# ENTRYPOINT ["tini", "-g", "--", "start.sh"]
# CMD ["start-notebook.py"]


COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# change jovyan
USER ${NB_UID}
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
