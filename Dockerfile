FROM hpess/base:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Install chef-client
RUN curl -s -L https://www.opscode.com/chef/install.sh | bash

# Setup the directories that are required
RUN mkdir -p /etc/chef && \
    mkdir -p /chef

# If we're running in local mode, you should mount this directory
VOLUME ["/chef"]
WORKDIR /chef

COPY start-chef.sh /usr/local/bin/start-chef.sh
ENTRYPOINT ["/bin/sh"]
CMD ["/usr/local/bin/start-chef.sh"]
