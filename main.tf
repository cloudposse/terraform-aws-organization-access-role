# https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.master_account_id}:root"]
    }

    effect = "Allow"
  }
}

# https://www.terraform.io/docs/providers/aws/r/iam_role.html
resource "aws_iam_role" "default" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = "The role to grant permissions to this account to delegated IAM users in the master account"
}

# https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html
# By default it attaches `AdministratorAccess` managed policy to grant full access to AWS services and resources in the current account
resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.default.name
  policy_arn = var.policy_arn
}
