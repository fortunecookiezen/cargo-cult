#!/usr/bin/env bash
set -euf -o pipefail
BUCKET_NAME="$1"
if [[ -z "$BUCKET_NAME" ]]; then
  echo "Usage: $0 <bucket-name>"
  exit 1
fi
echo "Setting lifecycle configuration for bucket: $BUCKET_NAME"
aws s3api put-bucket-lifecycle-configuration --bucket "$BUCKET_NAME" --lifecycle-configuration '{
  "Rules": [{
      "Expiration": {
        "Days": 1
      },
      "ID": "FullDelete",
      "Filter": {
        "Prefix": ""
      },
      "Status": "Enabled",
      "NoncurrentVersionExpiration": {
        "NoncurrentDays": 1
      },
      "AbortIncompleteMultipartUpload": {
        "DaysAfterInitiation": 1
      }
    },
    {
      "Expiration": {
        "ExpiredObjectDeleteMarker": true
      },
      "ID": "DeleteMarkers",
      "Filter": {
        "Prefix": ""
      },
      "Status": "Enabled"
    }
  ]
}'
echo "Lifecycle configuration for bucket '$BUCKET_NAME' has been set to delete objects after 1 day and delete markers."
echo "You can verify the configuration with: aws s3api get-bucket-lifecycle-configuration --bucket '$BUCKET_NAME'"
echo "Note: Ensure that you have the necessary permissions to modify the bucket lifecycle configuration."
echo "This script is intended for use in a controlled environment where immediate deletion of objects is acceptable."
echo "Use with caution, as this will permanently delete objects after the specified period."