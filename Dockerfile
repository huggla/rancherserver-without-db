FROM rancher/server

RUN apt-get update && apt-get purge -y mysql-server && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
