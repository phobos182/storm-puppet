# Class: storm
#
# This module manages storm
#
# Parameters: None
#
# Actions: None
#
# Requires: None
#
# Sample Usage: include storm
#
class storm (
  $storm_version = hiera('storm_version', '0.8.1'),
  $storm_libjzmq_version = hiera('storm_libjzmq_version', '2.1.7'),
  $storm_libzmq1_version = hiera('storm_libzmq1_version', '2.1.7'),
  $storm_zookeeper_servers  = hiera_array('storm_zookeeper_servers', ['localhost']),
  $storm_local_dir = hiera('storm_local_dir', '/var/lib/storm'),
  $storm_java_library_path = hiera_array('storm_java_library_path', ['/usr/local/lib', '/usr/lib', '/usr/lib/storm']),
  $storm_nimbus_host = hiera('storm_nimbus_host', 'localhost'),
  $storm_supervisor_start_port = hiera('supervisor_slots_start_port', '6700'),
  $storm_supervisor_workers = hiera('supervisor_workers', '4'),
  $storm_drpc_servers = hiera_array('storm_drpc_servers', ['']),
  $storm_user = hiera('storm_user', 'storm'),
  $storm_home = hiera('storm_home', '/usr/lib/storm'),
  $storm_conf = hiera('storm_conf', '/etc/storm'),
  $storm_ui_jvm_memory = hiera('storm_ui_jvm_memory', '768m'),
  $storm_drpc_jvm_memory = hiera('storm_drpc_jvm_memory', '768m'),
  $storm_nimbus_jvm_memory = hiera('storm_nimbus_jvm_memory', '768m'),
  $storm_supervisor_jvm_memory = hiera('storm_supervisor_jvm_memory', '768m'),
  $storm_options = hiera_array('storm_options', []),
  $storm_config = hiera_hash('storm_config', {}),
  $storm_nimbus = hiera('storm_nimbus', undef),
  $storm_supervisor = hiera('storm_supervisor', undef),
  $storm_ui = hiera('storm_ui', undef),
  $storm_drpc = hiera('storm_drpc', undef)
){
  class { 'storm::install': } ->
  class { 'storm::config': }

}
