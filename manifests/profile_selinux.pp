class puppetmaster::profile_selinux (
  $mode = 'disabled',
) {
  class { 'selinux':
    mode => $mode,
  }
}