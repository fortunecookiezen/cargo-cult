# sets up an ec2 instance profile to allow access and management via ssm
# 
# reference in your code as aws_iam_instance_profile.ssm_instance_profile.name
#
resource "aws_iam_role_policy_attachment" "ssm_role" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "ssm_role" {
  name_prefix = "ec2-ssm-role-"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name_prefix = "ec2-ssm-instance-profile-"
  role        = aws_iam_role.ssm_role.name
}
