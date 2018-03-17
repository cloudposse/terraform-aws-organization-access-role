output "role_name" {
  value = "${aws_iam_role.default.name}"
}

output "role_id" {
  value = "${aws_iam_role.default.unique_id}"
}

output "role_arn" {
  value = "${aws_iam_role.default.arn}"
}
