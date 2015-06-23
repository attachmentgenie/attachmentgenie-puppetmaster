class puppetmaster::profile_activemq (
  $memoryusage         = '200 mb',
  $storeusage          = '1 gb',
  $tempusage           = '1 gb',
  $console             = false,
  $instance            = 'mcollective',
  $middleware_user     = 'mcollective',
  $middleware_password = 'marionette',
  $version             = '5.9.1-2.el6',
  $webconsole          = true,
) {
  class { '::activemq':
    instance           => $instance,
    mq_cluster_brokers => [$::fqdn],
    version            => $version,
    webconsole         => $webconsole,
  }
  file { '/usr/share/activemq/activemq-data':
    ensure  => 'link',
    target  => '/var/cache/activemq/data',
    require => Package['activemq'],
    notify  => Service['activemq'],
  }
}
