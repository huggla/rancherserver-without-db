FROM rancher/server:v1.6.23 as stage1

ARG ENTRYPOINT="/usr/bin/entry"

RUN service mysql stop \
  && apt-get purge -y mysql-server \
  && rm -rf /etc/mysql/* \
  && apt-get autoremove -y --purge \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* \
  && { echo '#!/bin/sh' && export -p && echo "exec $ENTRYPOINT "'"$@"'; } > /usr/bin/env-entrypoint \
  && chmod +x /usr/bin/env-entrypoint
  
FROM scratch

COPY --from=stage1 / /

ENTRYPOINT ["/usr/bin/env-entrypoint"]
CMD ["/usr/bin/s6-svscan", "/service"]
