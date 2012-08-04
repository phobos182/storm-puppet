# Class: storm::supervisor
#
# This module manages storm supervisoration
#
# Parameters: None
#
# Actions: None
#
# Requires: storm::install
#
# Sample Usage: include storm::supervisor
#
class storm::supervisor {
  require storm::install
  include storm::config
  include storm::params

  # Install supervisor /etc/default
  storm::service::install { 'supervisor': start => 'yes', jvm_memory => $storm::params::supervisor_mem }

  # Install monit check
  monit::module::install { 'process_storm_supervisor': }

}
