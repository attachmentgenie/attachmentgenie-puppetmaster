class puppetmaster::profile_foreman_proxy (
  $foreman_host = 'foreman',
  $protocol     = 'https',
  $puppetca     = false,
  $puppetrun    = true,
  $version      = 'present',
) {
  class { '::foreman_proxy':
    foreman_base_url => "${protocol}://${foreman_host}",
    trusted_hosts    => [$::fqdn, $foreman_host],
    bmc              => false,
    dhcp             => false,
    dns              => false,
    puppetca         => $puppetca,
    puppetrun        => $puppetrun,
    tftp             => false,
    version          => $version,
  }
}