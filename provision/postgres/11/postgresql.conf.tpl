listen_addresses = '*'

max_connections = '100'

shared_buffers = '512MB'

work_mem = '5MB'
maintenance_work_mem = '128MB'
dynamic_shared_memory_type = 'posix'

wal_buffers = '16MB'
max_wal_size = '2GB'
min_wal_size = '1GB'

checkpoint_completion_target =  '0.7'
effective_cache_size = '1GB'
default_statistics_target = '100'

log_timezone = 'UTC'
datestyle = 'iso, mdy'
timezone = 'UTC'

lc_messages = 'en_US.utf8'
lc_monetary = 'en_US.utf8'
lc_numeric = 'en_US.utf8'
lc_time = 'en_US.utf8'

default_text_search_config = 'pg_catalog.english'