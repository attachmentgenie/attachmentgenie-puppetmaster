class puppetmaster::role_puppetmaster () {
  class { '::epel': } ->
  class { '::orchestrate::profile_time': } ->
  class { '::orchestrate::profile_selinux': } ->
  class { '::orchestrate::profile_firewall': } ->
  class { '::puppetmaster::stack_puppetmaster': }
}