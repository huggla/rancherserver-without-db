FROM rancher/server:v1.6.21 as stage1

RUN service mysql stop \
  && apt-get purge -y mysql-server \
  && rm -rf /etc/mysql/* \
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* \
  && echo '#!/bin/sh -e' > /entry \
  && env >> /entry \
  && echo >> /entry \
  && echo 'exec /usr/bin/entry $@' >> /entry \
  && chmod +x /entry
  
FROM scratch

COPY --from=stage1 / /

ENTRYPOINT ["/entry"]
CMD ["/usr/bin/s6-svscan", "/service"]
