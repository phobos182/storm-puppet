# Class: storm::supervisor
#
# This module manages storm supervisoration
#
# Parameters: None
#
# Actions: None
#
# Requires: storm:install
#
# Sample Usage: include storm::supervisor
#
class storm::supervisor {
  include storm::install
  include storm::config
  include storm::service::supervisor

  # Variables
  $storm_supervisor = $::storm::storm_supervisor
  $storm_supervisor_jvm_memory = $::storm::storm_supervisor_jvm_memory

  # Ordering
  Class['storm::install'] ->
  Class['storm::config'] ->
  Class['storm::supervisor'] ~>
  Class['storm::service::supervisor']

  file { '/etc/default/storm-supervisor':
    content => template('storm/storm-supervisor.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }

}
