output "role_name" {
  value       = "${aws_iam_role.default.name}"
  description = "The name of the crated role"
}

output "role_id" {
  value       = "${aws_iam_role.default.unique_id}"
  description = "The stable and unique string identifying the role"
}

output "role_arn" {
  value       = "${aws_iam_role.default.arn}"
  description = "The Amazon Resource Name (ARN) specifying the role"
}
