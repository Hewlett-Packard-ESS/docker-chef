# hpess/chef
This builds on the hpess/base image and installs chef-client for surface level configuration

## Chef-client
Chef-Client is pre installed and configured as a supervisor process, running on a 120 second interval.

The general idea is that chef-client will only provide surface level configuration of the container, no actual package installations.

In order for chef-client to run OK and register itself on the chef server, you need to provide it with a client.rb:
```
chef_server_url "https://your-chef-server"
ssl_verify_mode :verify_none
```
and a validation.pem, which you can get from the chef server itself.

So, your Dockerfile could look like this:
```
FROM hpess/base:latest
ADD client.rb /etc/chef/client.rb
ADD validation.pem /etc/chef/validation.pem
```
Or, your fig.yml could look like this:
```
chef:
  image: hpess/base
  volumes:
   - ./client:/etc/etc
```
where ./client contains a client.rb and validation.pem
