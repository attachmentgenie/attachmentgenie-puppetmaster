class puppetmaster::role_proxy () {
  class { '::orchestrate::profile_time': } ->
  class { '::orchestrate::profile_firewall': } ->
  class { '::puppetmaster::profile_haproxy': }
}