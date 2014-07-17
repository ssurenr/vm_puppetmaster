# == Class: dhcpserver
#
# Full description of class dhcpserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this modules would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { dhcpserver:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class dhcpserver {
package {
    'isc-dhcp-server':
        ensure      => installed,
}

service {
    'isc-dhcp-server':
        ensure      => running,
        enable      => true,
        hasrestart  => true,
        hasstatus   => true,
}

file {
    '/etc/dhcp/dhcpd.conf':
        ensure  => file,
        source  => "puppet:///modules/dhcpserver/dhcpd.conf",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package["isc-dhcp-server"],
        notify  => Service["isc-dhcp-server"],
}

file {
    '/etc/default/isc-dhcp-server':
        ensure  => file,
        source  => "puppet:///modules/dhcpserver/isc-dhcp-server",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package["isc-dhcp-server"],
} 

}
