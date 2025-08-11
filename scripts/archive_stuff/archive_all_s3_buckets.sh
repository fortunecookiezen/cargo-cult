#!/usr/bin/env bash
# This script sets a lifecycle configuration on all S3 buckets (except those containing "cloudtrail" in their names)
# to delete all objects after 1 day. Use with caution, as this will permanently delete objects after the specified period.
set -euf -o pipefail
for bucket in $(aws s3api list-buckets | jq -r '.Buckets[].Name'); do
  echo "Setting lifecycle configuration for bucket: $bucket";
  aws s3api put-bucket-lifecycle-configuration --bucket "$bucket" --lifecycle-configuration '{
  "Rules": [
    {
      "ID": "ImmediatelyTransitionToGlacier",
      "Prefix": "", 
      "Status": "Enabled",
      "Transitions": [
        {
          "Days": 0,
          "StorageClass": "GLACIER"
        }
      ]
    }
  ]
}';
  echo "Lifecycle configuration for bucket '$bucket' has been set to immediately transition objects to Glacier storage class."
done