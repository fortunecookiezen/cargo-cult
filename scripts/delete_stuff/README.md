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

### ECR

#### Delete all ECR repositories

```bash
for repo_name in $(aws ecr describe-repositories --query "repositories[*].repositoryName" | jq -r '.[]'); do
    echo "Deleting repository: $repo_name"
    aws ecr delete-repository --repository-name "$repo_name" --force
done
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

### SecretsManager

#### Delete all the secrets

```bash
for secret_arn in $(aws secretsmanager list-secrets --query 'SecretList[*].ARN' | jq -r '.[]'); do
  aws secretsmanager delete-secret --secret-id "$secret_arn" --recovery-window-in-days 7
done
```

#### Delete all the secrets right now!

```bash
for secret_arn in $(aws secretsmanager list-secrets --query 'SecretList[*].ARN' | jq -r '.[]'); do
  aws secretsmanager delete-secret --secret-id "$secret_arn" --force-delete-without-recovery
done
```

### SNS

#### Delete all the SNS Topics matching a string in a region

```bash
for topic_arn in $(aws sns list-topics --query "Topics[?contains(TopicArn, 'test')].TopicArn" | jq -r '.[]'); do echo "Deleting topic: $topic_arn"; aws sns delete-topic --topic-arn "$topic_arn"; done
```

Delete all the SNS topics in a region

```bash
for topic_arn in $(aws sns list-topics | jq -r '.Topics.[].TopicArn'); do echo "Deleting topic: $topic_arn"; aws sns delete-topic --topic-arn "$topic_arn"; done
```

```bash
for topic_arn in $(aws sns list-topics --query "Topics[].TopicArn" | jq -r '.[]'); do echo "Deleting topic: $topic_arn"; aws sns delete-topic --topic-arn "$topic_arn"; done
```

### S3

List bucket names

```bash
aws s3api list-buckets --region $AWS_REGION --prefix fnbo-2-0 --query "Buckets[].Name" | jq -r '.[]'
```

#### Empty a versioned S3 Bucket

This will delete all objects from all buckets, as long as there aren't very many of them. [`empty_all_s3_buckets.sh`](./empty_all_s3_buckets.sh) is a better option for most use cases.

```bash
for bucket_name in $(aws s3api list-buckets --region $AWS_REGION --prefix fnbo-2-0 --query "Buckets[].Name" | jq -r '.[]'); do echo "Emptying bucket $bucket_name"; aws s3api delete-objects --bucket $bucket_name --delete "$(aws s3api list-object-versions --bucket $bucket_name --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')";done
```

This will delete all objects in a versioned bucket, as long as there aren't very many of them. [`put_s3_deletion_config.sh`](./put_s3_deletion_config.sh) is a better option for most use cases.

```bash
aws s3api delete-objects --bucket my-bucket-us-east-1 \
--delete "$(aws s3api list-object-versions --bucket my-bucket-us-east-1 \
--output json \
--query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}')" --no-cli-pager
```
