import boto3
import logging
import os
from botocore.exceptions import ClientError

logger = logging.getLogger(__name__)

def enable_key_rotation():
    kms = boto3.client("kms", region_name=os.getenv('AWS_DEFAULT_REGION', "us-east-1"))
    kms_keys = kms.list_keys(Limit=1000)['Keys']
    for key in kms_keys:
        try:
            kms.enable_key_rotation(KeyId=str(key['KeyId']))
            kms.tag_resource(
                KeyId=str(key['KeyId']), 
                Tags=[
                    {
                        'TagKey' : 'Rotation',
                        'TagValue' : 'Enabled'
                    },
                ]
            )
        except ClientError:
            logger.exception("Could not enable rotation for key: " + str(key['KeyId']))
if __name__ == '__main__':
    enable_key_rotation()