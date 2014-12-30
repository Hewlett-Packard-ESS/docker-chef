# hpess/chef
This builds on the hpess/base image and installs chef-client for surface level configuration.

Some people believe that chef and docker are mutually exclusive, i personally disagree.  I like to have 95% of what is required to run the application in the container, ready to go, and then use chef for minor surface level configurance in each instance.

## Chef-client
At the moment I'm only supporting local-mode, that is, running cookbooks and recipes which are physically present in the /chef volume.

The general idea is that you can either mount a /chef volume containing your cookbooks:
```
docker run -it --rm -v ./your/cookbooks:/chef -e="chef_run_list=cookbook" hpess/chef
```
Or you can create your own Dockerfile which copies in the cookbooks:
```
FROM hpess/chef
COPY chef/* /chef
ENV chef_run_list cookbook
```

## Google Compute Engine IMPORTANT!
I discovered a strange issue with chef-client, even when running in local mode.  Basically on startup it seems to be trying to request from metadata.google.internal.  Only after it times out, does the client run continue.

I don't use GCE, nor does anyone I know, and i've discovered that by having `127.0.0.1 metadata.google.internal` in your host file, it makes the startup of chef-client almost instant.  This is added to the container automatically.

However, as I don't want to cause issues for GCE users, if you set the environment variables chef_gce="true", this line will not be added.

## Summary
To be clear, the purpose of this container is **not** to be run on its own, its built to form the foundations of other containers.

I use it in a number of other applications (chef out hpess/dockerproxy) for example, which is a squid/dnsmasq container but using chef to configure the applications as per the users environmental variables.
