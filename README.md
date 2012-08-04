Puppet Storm
==============================================================

Puppet module for configuration of storm clusters

Hiera backed configuration variables are used in this module to separate code from installation routines. You can see an example storm.yaml file for overriding defaults specified in params.pp. With your own internal Hiera scoping, you can create multiple storm clusters with different settings easily.

Requirements
------------
You must have your own internal repository and include the 3 packages
compiled for Debian / Ubuntu (storm, libjzmq, libzmq0). You can also modify this module to use your
own internal packaging as you see fit. You can find the .deb packaging for
storm here (<https://github.com/phobos182/storm-deb-packaging>). This module makes a lot of assumptions regarding /etc/default/storm* for Storm configuration settings.

Puppet requirements

* Hiera (<http://puppetlabs.com/blog/first-look-installing-and-using-hiera/>)

Usage
-----

The module has a few features. We do not specify individual ports for supervisors. We specify a start port, and a number of workers. Puppet will then iterate over the port list, and create the ports in the storm.yaml file for you. This reduces the headache with manually specifying ports. 

This module also uses Hiera backing for variable discovery. This allows you to setup different clusters with slightly changed settings very easily. An example hiera.yaml scope configuration is listed below.

Example Hiera Scoping (hiera.yaml)

    ---
    :backends:  - yaml
    :hierarchy: - %{hostname}
                - %{environment}/%{cluster}/%{calling_module}
                - %{environment}/%{calling_module}
                - %{environment}
                - common
    :yaml:
      :datadir: '/etc/puppet/hieradata'

With this scoping you should be able to setup Storm clusters by environment, and arbitrary 'cluster' tag. Host specific settings are in the highest scope, followed by cluster / module specific settings. Here is an example node.pp file, and storm.yaml file to specify a production storm cluster with overridden zookeeper / nimbus settings.

Node Definition (node.pp)

    #_ STORM _#
    node /storm[1-9]/ {
      $cluster = 'storm1'
      include storm::supervisor
    }
    
    node 'nimbus1' {
      $cluster = 'storm1'
      include storm::nimbus
      include storm::ui
    }

Hiera Configuration for Storm1 cluster (/etc/puppet/hieradata/production/storm1/storm.yaml)

    ---
    #_ ZOOKEEPER _#
    storm_zookeeper_servers:
      - 'zoo1'
      - 'zoo2'
      - 'zoo3'
    
    #_ NIMBUS _#
    nimbus_host: 'nimbus1'
    
    #_ SUPERVISOR _#
    supervisor_workers: '50'

You can use hiera to override memory settings by host, or by cluster. It's all up to your hiera.yaml scoping resolution. If you have any questions, or improvements. Please submit a pull request / issue.

Thanks!
