# Class: storm::drpc
#
# This module manages storm drpcation
#
# Parameters: None
#
# Actions: None
#
# Requires: storm:install
#
# Sample Usage: include storm::drpc
#
class storm::drpc {
  include storm::install
  include storm::config
  include storm::service::drpc

  # Variables
  $storm_drpc = $::storm::storm_drpc
  $storm_drpc_jvm_memory = $::storm::storm_drpc_jvm_memory

  # Ordering
  Class['storm::install'] ->
  Class['storm::config'] ->
  Class['storm::drpc'] ~>
  Class['storm::service::drpc']

  Class['storm::config'] ~>
  Class['storm::service::drpc']

  file { '/etc/default/storm-drpc':
    content => template('storm/storm-drpc.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }

}
