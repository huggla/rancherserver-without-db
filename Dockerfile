FROM rancher/server:v1.6.18 as server

FROM rancher/server:v1.6.18

RUN service mysql stop \
  && apt-get purge -y mysql-server \
  && rm -rf /etc/mysql/* \
  && apt-get autoremove -y --purge \
  && rm -rf /var/lib/apt/lists/*
  
FROM rancher/server-base:v1.0.0

COPY --from=server / /
