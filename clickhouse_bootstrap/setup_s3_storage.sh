#!/bin/sh
set -e

# Path for the generated storage configuration
CONFIG_FILE="/etc/clickhouse-server/config.d/storage.xml"

# Check if S3 environment variables are set and not empty
if [ -n "$S3_HOST" ] && [ -n "$S3_BUCKET" ] && [ -n "$S3_KEY" ] && [ -n "$S3_SECRET" ]; then
    echo "S3 credentials found. Generating S3 storage configuration."

    # Use a heredoc to create the storage configuration file.
    # The variables will be substituted with their values from the environment.
    cat >"$CONFIG_FILE" <<EOF
<clickhouse>
  <storage_configuration>
    <disks>
        <default>
            <!-- Set free space to keep on the local disk, e.g., 20GB -->
            <keep_free_space_bytes>21474836480</keep_free_space_bytes>
        </default>
        <s3_storage>
            <type>s3</type>
            <endpoint>http://${S3_HOST}/${S3_BUCKET}/${S3_PREFIX:-}</endpoint>
            <access_key_id>${S3_KEY}</access_key_id>
            <secret_access_key>${S3_SECRET}</secret_access_key>
            <metadata_path>/var/lib/clickhouse/s3_metadata/</metadata_path>
            <cache_enabled>true</cache_enabled>
            <data_cache_enabled>true</data_cache_enabled>
            <cache_path>/var/lib/clickhouse/s3_cache/</cache_path>
            <max_cache_size>2Gi</max_cache_size>
            <thread_pool_size>100</thread_pool_size>
        </s3_storage>
    </disks>
    <policies>
        <tiered>
            <volumes>
                <default>
                    <disk>default</disk>
                    <volume_priority>1</volume_priority>
                </default>
                <s3>
                    <disk>s3_storage</disk>
                    <prefer_not_to_merge>false</prefer_not_to_merge>
                    <perform_ttl_move_on_insert>false</perform_ttl_move_on_insert>
                    <volume_priority>2</volume_priority>
                </s3>
            </volumes>
            <!-- Move data to S3 when local disk is 5% full -->
            <move_factor>0.05</move_factor>
        </tiered>
    </policies>
  </storage_configuration>
</clickhouse>
EOF

    echo "Configuration file '$CONFIG_FILE' created."
else
    echo "S3 credentials not found. Skipping S3 storage configuration."
    # If the config file might exist from a previous run, remove it
    rm -f "$CONFIG_FILE"
fi
