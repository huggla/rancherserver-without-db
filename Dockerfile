FROM rancher/server:v1.6.22 as tmp

RUN service mysql stop \
  && apt-get purge -y mysql-server \
  && rm -rf /etc/mysql/* \
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/*
  
FROM scratch

COPY --from=tmp / /

