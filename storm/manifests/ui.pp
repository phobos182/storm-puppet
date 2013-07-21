# Class: storm::ui
#
# This module manages storm uiation
#
# Parameters: None
#
# Actions: None
#
# Requires: storm:install
#
# Sample Usage: include storm::ui
#
class storm::ui {
  include storm::install
  include storm::config
  include storm::service::ui

  # Variables
  $storm_ui = $::storm::storm_ui
  $storm_ui_jvm_memory = $::storm::storm_ui_jvm_memory

  # Ordering
  Class['storm::install'] ->
  Class['storm::config'] ->
  Class['storm::ui'] ~>
  Class['storm::service::ui']

  Class['storm::config'] ~>
  Class['storm::service::nimbus']

  file { '/etc/default/storm-ui':
    content => template('storm/storm-ui.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }

}
