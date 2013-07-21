# Class: storm::nimbus
#
# This module manages storm nimbusation
#
# Parameters: None
#
# Actions: None
#
# Requires: storm:install
#
# Sample Usage: include storm::nimbus
#
class storm::nimbus {
  include storm::install
  include storm::config
  include storm::service::nimbus

  # Variables
  $storm_nimbus = $::storm::storm_nimbus
  $storm_nimbus_jvm_memory = $::storm::storm_nimbus_jvm_memory

  # Ordering
  Class['storm::install'] ->
  Class['storm::config'] ->
  Class['storm::nimbus'] ~>
  Class['storm::service::nimbus']

  Class['storm::config'] ~>
  Class['storm::service::nimbus']

  file { '/etc/default/storm-nimbus':
    content => template('storm/storm-nimbus.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }

}
