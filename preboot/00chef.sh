#!/bin/bash
set -e
chef_local=${chef_local:-"true"}
chef_node_name=${chef_node_name:-$HOSTNAME}
chef_run_list=${chef_run_list:-""}
chef_interval=${chef_interval:-"0"}

chef_command="/usr/bin/chef-client -z -Fmin -c /etc/chef/client.rb -o $chef_run_list"
chef_service_config="/etc/supervisord.d/chef-client.service.conf"
chef_gce=${chef_gce:-"false"}
cd /chef

if [ "$chef_gce" == "false" ]; then
  echo "127.0.0.1 metadata.google.internal" >> /etc/hosts
fi

echo "node_name \"$chef_node_name\"" >> /etc/chef/client.rb

if [ "$chef_run_list" == "" ]; then
  echo " => WARNING: Chef run list was empty, skipping chef-client setup..."
else
  if [ "$chef_local" == "true" ]; then
    echo " => Please wait... running chef in local mode..."
    $chef_command
  fi

  if [ "$chef_interval" -gt "0" ]; then
    echo " => Chef interval set at $chef_interval.  Enabling Supervisord chef service..."

    echo "[program:chef-client]" > $chef_service_config
    echo "directory=/chef" >> $chef_service_config
    echo "command=$chef_command -i $chef_interval" >> $chef_service_config
  else
    echo " => WARNING: chef_interval was 0, therefore chef-client will not run periodically!"
  fi
fi
