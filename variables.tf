variable "master_account_id" {
  type        = string
  description = "The ID of the master account to grant permissions to access the current account"
}

variable "role_name" {
  type        = string
  default     = "OrganizationAccountAccessRole"
  description = "The name of the role to grant permissions to delegated IAM users in the master account to the current account"
}

variable "policy_arn" {
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
  description = "Policy ARN to attach to the role. By default it attaches `AdministratorAccess` managed policy to grant full access to AWS services and resources in the current account"
}
