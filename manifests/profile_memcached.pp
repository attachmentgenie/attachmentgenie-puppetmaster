class puppetmaster::profile_memcached (
  $max_memory = '50%',
) {
  class { 'memcached':
    max_memory => $max_memory,
  }
}