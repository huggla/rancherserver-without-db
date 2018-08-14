FROM rancher/server:v1.6.21 as stage1

ARG ENTRYPOINT="/usr/bin/entry"

RUN service mysql stop \
  && apt-get purge -y mysql-server \
  && rm -rf /etc/mysql/* \
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* \
  && { echo '#!/bin/sh' && set | xargs -0 -d \n echo "export"; } > /usr/bin/env-entrypoint \
  && chmod +x /usr/bin/env-entrypoint
  
FROM scratch

COPY --from=stage1 / /

ENTRYPOINT ["/env-entrypoint"]
CMD ["/usr/bin/s6-svscan", "/service"]
