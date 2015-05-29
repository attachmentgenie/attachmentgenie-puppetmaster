class puppetmaster::stack_node (
  $mco_server = false,
) {
  if $mco_server {
    class { '::puppetmaster::profile_mcollective': }
  }
}