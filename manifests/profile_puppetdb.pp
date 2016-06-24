class puppetmaster::profile_puppetdb (
  $java_args          = {
    '-Xmx' => '512m',
    '-Xms' => '256m',
  },
  $listen_address     = '0.0.0.0',
  $manage_dbserver    = true,
  $manage_firewall    = false,
  $manage_pg_repo     = true,
  $ssl_listen_address = '0.0.0.0',
) {
  class { '::puppetdb':
    java_args          => $java_args,
    listen_address     => $listen_address,
    manage_dbserver    => $manage_dbserver,
    manage_firewall    => $manage_firewall,
    ssl_listen_address => $ssl_listen_address,
  }
}