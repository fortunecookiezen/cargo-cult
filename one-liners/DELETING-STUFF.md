# DELETING STUFF

## AWS

### EBS

#### Delete EBS Volumes in account

```bash
for volume_id in $(aws ec2 describe-volumes --query "Volumes[].VolumeId" | jq -r '.[]'); do echo "Deleting volume_id $volume_id"; aws ec2 delete-volume --volume-id $volume_id; done
```

#### Delete-EBS-Snapshots

You may need to [deregister](#deregister-amis) any amis in the account that may be using snapshots before you can delete the snapshots

##### Delete EBS Snapshots owned by the current account

```bash
for snapshot_id in $(aws ec2 describe-snapshots --owner-ids $(aws sts get-caller-identity --query "Account" --output text) --query "Snapshots[].SnapshotId" | jq -r '.[]'); do echo "Deleting snapshot $snapshot_id"; aws ec2 delete-snapshot --snapshot-id $snapshot_id; done
```

### EC2

#### Deregister-AMIs

```bash
for image_id in $(aws ec2 describe-images --owners $(aws sts get-caller-identity --query "Account" --output text) --query "Images[].ImageId" | jq -r '.[]'); do echo "Deregistering image_id $image_id"; aws ec2 deregister-image --image-id $image_id --delete-associated-snapshots; done
```

### RDS

```bash
for snapshot in $(aws rds describe-db-cluster-snapshots --snapshot-type manual --query "DBClusterSnapshots[].DBClusterSnapshotIdentifier" --output text); do echo "Deleting snapshot $snapshot"; done
```

```bash
aws rds delete-db-cluster --db-cluster-identifier $db_cluster_id --skip-final-snapshot --delete-automated-backups
```

```bash
aws rds describe-db-clusters --query "DBClusters[].DBClusterIdentifier" | jq -r '.[]'
```

```bash
for db_cluster_id in $(aws rds describe-db-clusters --query "DBClusters[].DBClusterIdentifier" | jq -r '.[]'); do echo "Deleting db_cluster $db_cluster_id"; aws rds delete-db-cluster --db-cluster-identifier $db_cluster_id --skip-final-snapshot --delete-automated-backups --no-cli-pager; done
```

### SNS

Delete all the SNS Topics matching a string in a region

```bash
for topic_arn in $(aws sns list-topics --query "Topics[?contains(TopicArn, 'test')].TopicArn" | jq -r '.[]'); do echo "Deleting topic: $topic_arn"; aws sns delete-topic --topic-arn "$topic_arn"; done
```

```bash
for topic_arn in $(aws sns list-topics | jq -r '.Topics.[].TopicArn'); do echo "Deleting topic: $topic_arn"; aws sns delete-topic --topic-arn "$topic_arn"; done
```

```bash
for topic_arn in $(aws sns list-topics --query "Topics[].TopicArn" | jq -r '.[]'); do echo "Deleting topic: $topic_arn"; aws sns delete-topic --topic-arn "$topic_arn"; done
```
### S3

Empty a versioned S3 Bucket

```bash
aws s3api list-buckets --region $AWS_REGION --prefix fnbo-2-0 --query "Buckets[].Name" | jq -r '.[]'
```

```bash
for bucket_name in $(aws s3api list-buckets --region $AWS_REGION --prefix fnbo-2-0 --query "Buckets[].Name" | jq -r '.[]'); do echo "Emptying bucket $bucket_name"; aws s3api delete-objects --bucket $bucket_name --delete "$(aws s3api list-object-versions --bucket $bucket_name --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')";done
```

```bash
aws s3api delete-objects --bucket fnbo-2-0-fnbo-2-0-dev-dev-storage-dev-us-east-1 --delete "$(aws s3api list-object-versions --bucket fnbo-2-0-fnbo-2-0-dev-dev-storage-dev-us-east-1 \
--output json --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" --no-cli-pager
```

```bash
aws s3api delete-objects --bucket fnbo-2-0-fnbo-2-0-dev-1099-storage-dev-us-east-1 \
--delete "$(aws s3api list-object-versions --bucket fnbo-2-0-fnbo-2-0-dev-1099-storage-dev-us-east-1 \
--output json \
--query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" --no-cli-pager
```

```bash
aws s3api delete-objects --bucket fnbo-2-0-fnbo-2-0-dev-snowflake-dev-dev-us-east-1 \
--delete "$(aws s3api list-object-versions --bucket fnbo-2-0-fnbo-2-0-dev-snowflake-dev-dev-us-east-1 \
--output json \
--query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" --no-cli-pager
```