class puppetmaster::stack_puppetmaster (
  $foreman       = false,
  $foreman_proxy = false,
  $mcollective   = false,
  $puppetca      = false,
  $puppetdb      = false,
  $r10k          = false,
) {
  if !defined(Class['::puppetmaster::profile_puppet']) {
    class { '::puppetmaster::profile_puppet': }
  }
  if $puppetca and $r10k {
    class { '::profile_r10k': }
  }
  if $puppetca and $foreman_proxy {
    class { '::puppetmaster::profile_foreman_proxy': }
    Class['::puppet'] ->
    Class['::foreman_proxy']
  }
  if $foreman {
    class { '::puppetmaster::profile_foreman': }
    Class['::puppet'] ->
    Class['::foreman']
    if $puppetdb {
      Class['::foreman'] ->
      Class['::puppetdb::server']
    }
  }
  if $mcollective {
    class { '::puppetmaster::profile_mcollective': }
  }
  if $puppetdb {
    class { '::puppetmaster::profile_puppetdb': }
    if ($puppetca) {
      Class['::puppet::server::service'] ->
      Class['::puppetdb::server']
    }
  }
}