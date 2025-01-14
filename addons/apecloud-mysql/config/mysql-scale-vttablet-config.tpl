[vttablet]
health_check_interval=1s
shard_sync_retry_delay=1s
remote_operation_timeout=1s
db_connect_timeout_ms=500
table_acl_config_mode=simple
enable_logs=true
enable_query_log=true
table_acl_config=
queryserver_config_strict_table_acl=false
table_acl_config_reload_interval=30s
enforce_tableacl_config=false


{{- $phy_memory := getContainerMemory ( index $.podSpec.containers 0 ) }}
{{- $thread_stack := 262144 }}
{{- $binlog_cache_size := 32768 }}
{{- $join_buffer_size := 262144 }}
{{- $sort_buffer_size := 262144 }}
{{- $read_buffer_size := 262144 }}
{{- $read_rnd_buffer_size := 524288 }}
{{- $single_thread_memory := add $thread_stack $binlog_cache_size $join_buffer_size $sort_buffer_size $read_buffer_size $read_rnd_buffer_size }}
{{- if gt $phy_memory 0 }}
# max_connections={{ div ( div $phy_memory 4 ) $single_thread_memory }}
{{- end}}

# OltpReadPool
queryserver_config_pool_size=30

# OlapReadPool
queryserver_config_stream_pool_size=30

# TxPool
queryserver_config_transaction_cap=50