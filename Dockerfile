FROM selenium/standalone-chrome:3.6.0

USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
      curl \
  # Install dumb-init (to handle PID 1 correctly).
  # https://github.com/Yelp/dumb-init
  && url=https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb \
  && curl -Lo /tmp/dumb-init.deb $url \
  && dpkg -i /tmp/dumb-init.deb \
  # Clean up
  && apt-get purge --auto-remove -y \
      curl \
  && apt-get clean \
  && rm -rf /tmp/* /var/lib/apt/lists/*
USER seluser

EXPOSE 4444

ENTRYPOINT ["dumb-init"]
CMD ["/opt/bin/entry_point.sh"]
