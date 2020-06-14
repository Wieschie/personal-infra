module "iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "2.12.0"

  name = "Administrator"

  group_users = [module.iam_user.this_iam_user_name]

  attach_iam_self_management_policy = true

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
    "arn:aws:iam::aws:policy/job-function/Billing"
  ]
}

module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "2.12.0"

  name          = "Admin"
  force_destroy = true

  pgp_key = "keybase:wieschie"

  password_reset_required = true
  password_length         = 64
}