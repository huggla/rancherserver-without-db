FROM rancher/server:v1.6.21 as stage1

ENV ENTRYPOINT="/usr/bin/entry"

RUN service mysql stop \
  && apt-get purge -y mysql-server \
  && rm -rf /etc/mysql/* \
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* \
  && env > /env-entrypoint \
  && echo ". $ENTRYPOINT" >> /env-entrypoint
  
FROM scratch

COPY --from=stage1 / /

ENTRYPOINT ["/env-entrypoint"]
CMD ["/usr/bin/s6-svscan", "/service"]
