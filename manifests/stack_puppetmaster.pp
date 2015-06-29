class puppetmaster::stack_puppetmaster (
  $foreman          = false,
  $foreman_proxy    = false,
  $activemq         = false,
  $mcollective      = false,
  $mcollective_r10k = false,
  $puppetdb         = false,
  $puppetmaster     = false,
  $r10k             = false,
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
  if $puppetmaster and $foreman_proxy {
    class { '::puppetmaster::profile_foreman_proxy': }
    Class['::puppet'] ->
    Class['::foreman_proxy']
  }
  if $activemq {
    class { '::puppetmaster::profile_activemq': }
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
  if !defined(Class['::puppetmaster::profile_puppet']) {
    class { '::puppetmaster::profile_puppet': }
  }
  if $puppetdb {
    class { '::puppetmaster::profile_puppetdb': }
    if ($puppetmaster) {
      Class['::puppet::server::service'] ->
      Class['::puppetdb::server']
    }
  }
  if $r10k {
    class { '::puppetmaster::profile_r10k': }
  }
}