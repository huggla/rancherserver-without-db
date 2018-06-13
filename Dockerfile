FROM rancher/server:v1.6.18 as server

RUN service mysql stop \
  && apt-get purge -y mysql-server \
  && rm -rf /etc/mysql/* \
  && apt-get autoremove -y --purge \
  && rm -rf /var/lib/apt/lists/*
  
FROM scratch

COPY --from=server / /
