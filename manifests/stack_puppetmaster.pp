class puppetmaster::stack_puppetmaster (
  $activemq         = false,
  $foreman          = false,
  $foreman_proxy    = false,
  $haproxy_member   = false,
  $memcached        = false,
  $mcollective      = false,
  $mcollective_r10k = false,
  $puppetdb         = false,
  $puppetmaster     = false,
  $r10k             = false,
) {
  validate_bool($activemq)
  validate_bool($foreman)
  validate_bool($foreman_proxy)
  validate_bool($memcached)
  validate_bool($mcollective)
  validate_bool($mcollective_r10k)
  validate_bool($puppetdb)
  validate_bool($puppetmaster)
  validate_bool($r10k)

  if !defined(Class['::puppetmaster::profile_puppet']) {
    class { '::puppetmaster::profile_puppet': }
  }
  if $activemq {
    class { '::puppetmaster::profile_activemq': }
  }
  if $foreman {
    class { '::puppetmaster::profile_foreman': }
    Class['::puppet'] ->
    Class['::foreman']
    if $foreman and $foreman_proxy {
      Class['::foreman'] ->
      Class['::foreman_proxy::register']
    }
    if $puppetdb {
      Class['::foreman'] ->
      Class['::puppetdb::server']
    }
  }
  if $haproxy_member {
    class { '::puppetmaster::profile_haproxy_balancermember': }
  }
  if $memcached {
    class { '::puppetmaster::profile_memcached': }
    if $foreman and $memcached {
      Class['::memcached'] ->
      Class['::foreman']
    }
  }
  if $mcollective {
    if !defined(Class['::puppetmaster::profile_mcollective']) {
      class { '::puppetmaster::profile_mcollective': }
    }
    if $mcollective_r10k {
      class { '::puppetmaster::profile_mcollective_r10k': }
      Class['::puppetmaster::profile_mcollective'] ->
      Class['::r10k::mcollective']
    }
  }
  if $puppetdb {
    class { '::puppetmaster::profile_puppetdb': }
    if ($puppetmaster) {
      Class['::puppet::server::service'] ->
      Class['::puppetdb::server']
    }
  }
  if $puppetmaster and $foreman_proxy {
    class { '::puppetmaster::profile_foreman_proxy': }
    Class['::puppet'] ->
    Class['::foreman_proxy']
  }
  if $r10k {
    class { '::puppetmaster::profile_r10k': }
  }
}