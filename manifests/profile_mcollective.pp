class puppetmaster::profile_mcollective (
  $client           = false,
  $client_user      = 'vagrant',
  $middleware_hosts = [$::fqdn],
) {
  class { '::mcollective':
    client             => $client,
    middleware_hosts   => $middleware_hosts,
  }

  if $client {
    mcollective::user { 'vagrant': }
  }
}