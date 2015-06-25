class puppetmaster::profile_puppet (
  $allow_any_crl_auth          = true,
  $autosign                    = true,
  $autosign_domains            = ['*.vagrant'],
  $dns_alt_names               = [],
  $puppetmaster                = undef,
  $runmode                     = 'service',
  $server                      = false,
  $server_ca                   = true,
  $server_ca_proxy             = undef,
  $server_common_modules_path  = [],
  $server_environments         = [],
  $server_external_nodes       = '/etc/puppet/node.rb',
  $server_foreman              = false,
  $server_foreman_url          = "http://foreman",
  $server_implementation       = 'master',
  $server_parser               = 'current',
  $server_puppetdb_host        = undef,
  $server_reports              = 'store',
  $server_storeconfigs_backend = undef,
  $show_diff                   = true,
  $splay                       = true,
) {
  class { '::puppet':
    allow_any_crl_auth          => $allow_any_crl_auth,
    dns_alt_names               => $dns_alt_names,
    puppetmaster                => $puppetmaster,
    runmode                     => $runmode,
    server                      => $server,
    server_ca                   => $server_ca,
    server_ca_proxy             => $server_ca_proxy,
    server_common_modules_path  => $server_common_modules_path,
    server_environments         => $server_environments,
    server_external_nodes       => $server_external_nodes,
    server_foreman              => $server_foreman,
    server_foreman_url          => $server_foreman_url,
    server_implementation       => $server_implementation,
    server_parser               => $server_parser,
    server_puppetdb_host        => $server_puppetdb_host,
    server_reports              => $server_reports,
    server_storeconfigs_backend => $server_storeconfigs_backend,
    show_diff                   => $show_diff,
    splay                       => $splay,
  }
  if $server {
    file { '/etc/puppet/hiera.yaml':
      mode   => '0644',
      owner  => 'puppet',
      group  => 'puppet',
      source => 'puppet:///modules/puppetmaster/hiera.yaml',
    }
    Class['::puppet'] ->
    File['/etc/puppet/hiera.yaml']
    if $autosign {
      file { '/etc/puppet/autosign.conf':
        mode    => '0644',
        owner   => 'puppet',
        group   => 'puppet',
        content => template("puppetmaster/autosign.conf.erb"),
      }
      Class['::puppet'] ->
      File['/etc/puppet/autosign.conf']
    }
  }
}