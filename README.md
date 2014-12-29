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

To be clear, the purpose of this container is **not** to be run on its own, its built to form the foundations of other containers.

I use it in a number of other applications (chef out hpess/dockerproxy) for example, which is a squid/dnsmasq container but using chef to configure the applications as per the users environmental variables.
