# Class: storm::config
#
# This module manages the storm configuration directories
#
# Parameters: None
#
# Actions: None
#
# Requires: storm::install, storm
#
# Sample Usage: include storm::config
#
class storm::config {
  include storm::install

  # Variables
  $storm_zookeeper_servers = $::storm::storm_zookeeper_servers
  $storm_local_dir = $::storm::storm_local_dir
  $storm_java_library_path = $::storm::storm_java_library_path
  $storm_nimbus_host = $::storm::storm_nimbus_host
  $storm_supervisor_start_port = $::storm::storm_supervisor_start_port
  $storm_supervisor_workers = $::storm::storm_supervisor_workers
  $storm_drpc_servers = $::storm::storm_drpc_servers
  $storm_user = $::storm::storm_user
  $storm_home = $::storm::storm_home
  $storm_conf = $::storm::storm_conf
  $storm_ui_jvm_memory = $::storm::storm_ui_jvm_memory
  $storm_drpc_jvm_memory = $::storm::storm_drpc_jvm_memory
  $storm_nimbus_jvm_memory = $::storm::storm_nimbus_jvm_memory
  $storm_supervisor_jvm_memory = $::storm::storm_supervisor_jvm_memory
  $storm_options = $::storm::storm_options
  $storm_config = $::storm::storm_config
  $storm_nimbus = $::storm::storm_nimbus
  $storm_supervisor = $::storm::storm_supervisor
  $storm_ui = $::storm::storm_ui
  $storm_drpc = $::storm::storm_drpc

  # Ordering
  Class['storm::install'] ->
  Class['storm::config']

  # Configuration
  file { '/etc/storm/storm.yaml':
    content => template('storm/storm.yaml.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }

  file { '/etc/default/storm':
    content => template('storm/storm.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }

  # If enabled, include service
  if $storm_nimbus != undef {
    include storm::nimbus
  }
  if $storm_ui {
    include storm::ui
  }
  if $storm_supervisor {
    include storm::supervisor
  }
  if $storm_drpc {
    include storm::drpc
  }

}
