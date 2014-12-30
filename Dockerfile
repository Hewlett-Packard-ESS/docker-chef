FROM hpess/base:latest
MAINTAINER Karl Stoney <karl.stoney@hp.com>

# Install chef-client
RUN curl -s -L https://www.opscode.com/chef/install.sh | bash

# Setup the directories that are required
RUN mkdir -p /etc/chef && \
    mkdir -p /chef/cookbooks && \
    mkdir -p /chef/roles && \
    mkdir -p /chef/environments && \
    mkdir -p /chef/data_bags

# If we're running in local mode, you should mount this directory
VOLUME ["/chef"]
WORKDIR /chef

COPY client.rb /etc/chef/client.rb

# Add our preboot scripts
COPY preboot/* /preboot/ 
