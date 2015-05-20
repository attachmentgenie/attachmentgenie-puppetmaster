class puppetmaster::role_proxy () {
  class { '::puppetmaster::profile_ntp': }
  class { '::puppetmaster::profile_firewall': } ->
  class { '::puppetmaster::profile_haproxy': }
}