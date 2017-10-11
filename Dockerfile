FROM rancher/server

RUN apt-get update && service mysql stop && apt-get purge -y mysql-server && apt-get autoremove -y --purge && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/entry"]
CMD ["/usr/bin/s6-svscan", "/service"]
