# == Class: dns
#
# Full description of class dns here.
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
#  class { dns:
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
class dns {

package {
    'bind9':
        ensure      => installed,
}

service {
    'bind9':
        ensure      => running,
        enable      => true,
        hasrestart  => true,
        hasstatus   => true,
}

file {
    '/etc/bind/db.PE.lan':
        ensure  => file,
        source  => "puppet:///modules/dns/db.PE.lan",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package["bind9"],
        notify 	=> Service["bind9"],
}

file {
    '/etc/bind/named.conf.local':
        ensure  => file,
        source  => "puppet:///modules/dns/named.conf.local",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package["bind9"],
        notify 	=> Service["bind9"],
}

file {
    '/etc/bind/named.conf.options':
        ensure  => file,
        source  => "puppet:///modules/dns/named.conf.options",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Package["bind9"],
        notify 	=> Service["bind9"],
}

}
