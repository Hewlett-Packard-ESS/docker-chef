FROM hpess/base:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Install chef-client
RUN curl -L https://www.opscode.com/chef/install.sh | bash

# Setup the directories that are required
RUN mkdir -p /etc/chef

# Add the supervisor configuration
ADD chef-client.service.conf /etc/supervisord.d/chef-client.service.conf
