# AWS Config

## Queries

### Find all lambda functions with a certain runtime

```sql
SELECT
  accountId,
  arn,
  awsRegion,
  resourceId,
  configuration.runtime
WHERE
  resourceType = 'AWS::Lambda::Function'
  AND configuration.runtime = 'python3.9'
```
