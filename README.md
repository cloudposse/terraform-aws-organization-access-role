# terraform-aws-organization-access-role [![Build Status](https://travis-ci.org/cloudposse/terraform-aws-organization-access-role.svg?branch=master)](https://travis-ci.org/cloudposse/terraform-aws-organization-access-role)

Terraform module to create an IAM Role to grant permissions to delegated IAM users in the master account to access an invited member account

https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_access.html


## Introduction

By default, when you create a member account as part of your Organization, AWS automatically creates `OrganizationAccountAccessRole` in the member account.

The role grants admin permissions to the member account to delegated IAM users in the master account.

However, member accounts that you invite to join your Organization do not automatically get the role created.

This module creates `OrganizationAccountAccessRole` role in an invited member account.

AWS recommends using the same name, `OrganizationAccountAccessRole`, for the created role for consistency and ease of remembering.

<br/>

![OrganizationAccountAccessRole](images/OrganizationAccountAccessRole.png)


## Usage

```hcl
module "organization_access_role" {
  source            = "git::https://github.com/cloudposse/terraform-aws-organization-access-role.git?ref=master"
  master_account_id = "XXXXXXXXXXXX"
  role_name         = "OrganizationAccountAccessRole"
  policy_arn        = "arn:aws:iam::aws:policy/AdministratorAccess"
```


After the role has been created in the invited member account, login to the master account and create the following policy:

(change `YYYYYYYYYYYY` to the ID of the invited member account)

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": [
                "arn:aws:iam::YYYYYYYYYYYY:role/OrganizationAccountAccessRole"
            ]
        }
    ]
}
```


Then attach the policy to a master account Group that you want to delegate administration of the invited member account.

After that, users who are members of the Group in the master account will be able to assume the role and administer the invited member account by going here:

(change `YYYYYYYYYYYY` to the ID of the invited member account)

```
https://signin.aws.amazon.com/switchrole
                ?account=YYYYYYYYYYYY
                &roleName=OrganizationAccountAccessRole
                &displayName=Dev
```


__NOTE__: You can use [terraform-aws-organization-access-group](https://github.com/cloudposse/terraform-aws-organization-access-group) module
to create an IAM Group and Policy to grant permissions to delegated IAM users in the Organization's master account to access a member account.


## Variables

|  Name                   |  Default                          |  Description                                                                                       | Required |
|:------------------------|:----------------------------------|:---------------------------------------------------------------------------------------------------|:--------:|
| `master_account_id`     | ``                                | The ID of the master account to grant permissions to access the current account                    | Yes      |
| `role_name`             | `OrganizationAccountAccessRole`   | The name of the role to grant permissions to delegated IAM users in the master account to the current account   | No      |
| `policy_arn`            | `arn:aws:iam::aws:policy/AdministratorAccess`  | Policy ARN to attach to the role. By default it attaches `AdministratorAccess` managed policy to grant full access to AWS services and resources in the current account   | No      |


## Outputs

| Name                | Description                                         |
|:--------------------|:----------------------------------------------------|
| `role_name`         | The name of the crated role                         |
| `role_id`           | The stable and unique string identifying the role   |
| `role_arn`          | The Amazon Resource Name (ARN) specifying the role  |



## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-organization-access-role/issues), send us an [email](mailto:hello@cloudposse.com) or reach out to us on [Gitter](https://gitter.im/cloudposse/).


## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-organization-access-role/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing `terraform-aws-organization-access-role`, we would love to hear from you! Shoot us an [email](mailto:hello@cloudposse.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

**NOTE:** Be sure to merge the latest from "upstream" before making a pull request!


## License

[APACHE 2.0](LICENSE) © 2018 [Cloud Posse, LLC](https://cloudposse.com)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.


## About

`terraform-aws-organization-access-role` is maintained and funded by [Cloud Posse, LLC][website].

![Cloud Posse](https://cloudposse.com/logo-300x69.png)


Like it? Please let us know at <hello@cloudposse.com>

We love [Open Source Software](https://github.com/cloudposse/)!

See [our other projects][community]
or [hire us][hire] to help build your next cloud platform.

  [website]: https://cloudposse.com/
  [community]: https://github.com/cloudposse/
  [hire]: https://cloudposse.com/contact/


### Contributors

| [![Erik Osterman][erik_img]][erik_web]<br/>[Erik Osterman][erik_web] | [![Andriy Knysh][andriy_img]][andriy_web]<br/>[Andriy Knysh][andriy_web] |
|-------------------------------------------------------|------------------------------------------------------------------|

  [erik_img]: http://s.gravatar.com/avatar/88c480d4f73b813904e00a5695a454cb?s=144
  [erik_web]: https://github.com/osterman/
  [andriy_img]: https://avatars0.githubusercontent.com/u/7356997?v=4&u=ed9ce1c9151d552d985bdf5546772e14ef7ab617&s=144
  [andriy_web]: https://github.com/aknysh/
