class puppetmaster::stack_node (
  $mcollective = false,
) {
  if $mcollective {
    class { '::puppetmaster::profile_mcollective': }
  }
}