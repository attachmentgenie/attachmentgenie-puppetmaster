class puppetmaster::role_node {
  class { '::puppetmaster::profile_ntp': }
  class { '::puppetmaster::profile_firewall': } ->
  class { '::puppetmaster::profile_puppet': }
  class { '::puppetmaster::stack_node': }
}