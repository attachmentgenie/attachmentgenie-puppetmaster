class puppetmaster::role_puppetmaster () {
  class { '::epel': } ->
  class { '::puppetmaster::profile_ntp': } ->
  class { '::puppetmaster::profile_selinux': } ->
  class { '::puppetmaster::profile_firewall': } ->
  class { '::puppetmaster::stack_puppetmaster': }
}