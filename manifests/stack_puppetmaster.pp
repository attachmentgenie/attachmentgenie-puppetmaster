class puppetmaster::stack_puppetmaster (
  $foreman       = false,
  $foreman_proxy = false,
  $mco_broker    = false,
  $mco_client    = false,
  $puppetca      = false,
  $puppetdb      = false,
  $r10k          = false,
) {
  if $foreman {
    class { '::puppetmaster::profile_foreman': }
    Class['::puppet'] ->
    Class['::foreman']
    if $foreman {
      Class['::foreman'] ->
      Class['::foreman_proxy::register']
    }
    if $puppetdb {
      Class['::foreman'] ->
      Class['::puppetdb::server']
    }
  }
  if $puppetca and $foreman_proxy {
    class { '::puppetmaster::profile_foreman_proxy': }
    Class['::puppet'] ->
    Class['::foreman_proxy']
  }
  if $mco_broker {
    class { '::puppetmaster::profile_activemq': }
  }
  if $mco_client {
    if !defined(Class['::puppetmaster::profile_mcollective']) {
      class { '::puppetmaster::profile_mcollective': }
    }
  }
  if !defined(Class['::puppetmaster::profile_puppet']) {
    class { '::puppetmaster::profile_puppet': }
  }
  if $puppetdb {
    class { '::puppetmaster::profile_puppetdb': }
    if ($puppetca) {
      Class['::puppet::server::service'] ->
      Class['::puppetdb::server']
    }
  }
  if $r10k {
    class { '::puppetmaster::profile_r10k': }
  }
}