class puppetmaster::role_node {
  class { '::orchestrate::profile_time': }
  class { '::orchestrate::profile_firewall': } ->
  class { '::puppetmaster::profile_puppet': }
  class { '::puppetmaster::stack_node': }
}