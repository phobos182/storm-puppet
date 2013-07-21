# Class: storm::install
#
# This module manages storm installation
#
# Parameters: None
#
# Actions: None
#
# Requires:
#
# Sample Usage: include storm::install
#
class storm::install {

  # Variables
  $storm_version = $storm::storm_version
  $storm_libjzmq_version = $storm::storm_libjzmq_version
  $storm_libzmq1_version = $storm::storm_libzmq1_version

  package { 'storm':
    ensure => $storm_version
  }

  package { 'libjzmq':
    ensure => $storm_libjzmq_version
  }

  package { 'libzmq1':
    ensure => $storm_libzmq1_version
  }


}
