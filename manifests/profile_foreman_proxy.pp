class puppetmaster::profile_foreman_proxy (
  $foreman_host = 'foreman',
  $version      = 'present',
) {
  class { '::foreman_proxy':
    foreman_base_url => "http://${foreman_host}",
    trusted_hosts    => [$::fqdn, $foreman_host],
    bmc              => false,
    dhcp             => false,
    dns              => false,
    puppetca         => true,
    puppetrun        => true,
    tftp             => false,
    version          => $version,
  }
}