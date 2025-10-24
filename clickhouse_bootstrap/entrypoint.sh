#!/bin/sh
set -e

# Run the S3 storage setup script
setup_s3_storage.sh

# Execute the original ClickHouse entrypoint script
exec /entrypoint.sh
