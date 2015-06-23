class puppetmaster::profile_mcollective (
  $client           = false,
  $client_user      = 'vagrant',
  $middleware_hosts = [$::fqdn],
  $users            = { 'vagrant' => {} },
) {
  class { '::mcollective':
    client             => $client,
    middleware_hosts   => $middleware_hosts,
  }

  if $client {
    create_resources(mcollective::user, $users)
  }
}