resource "aws_iam_policy_attachment" "contributors-rds" {
    name = "RDS read-only access"
    groups = ["${aws_iam_group.contributors.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

resource "aws_iam_policy_attachment" "contributors-iam-read" {
    name = "RDS read-only access"
    groups = ["${aws_iam_group.contributors.name}"]
    policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_group_policy" "contributors-iam-access-keys" {
    name = "contributors-iam-access-keys"
    group = "${aws_iam_group.contributors.id}"
    policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "iam:CreateAccessKey",
        "iam:ListAccessKeys"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::981412958133:user/$${aws:username}"
    },
    {
      "Action": [
        "iam:DeleteAccessKey",
        "iam:GetAccessKeyLastUsed"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::981412958133:user/users/$${aws:username}/*"
    },
    {
      "Action": [
        "iam:ListUsers"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::981412958133:user/"
    }
  ]
}
EOF
}

resource "aws_iam_group_membership" "contributors" {
    name = "contributors"
    users = [
        "${aws_iam_user.ben.name}",
        "${aws_iam_user.eddie.name}",
        "${aws_iam_user.dolan.name}"
    ]
    group = "${aws_iam_group.contributors.name}"
}

resource "aws_iam_group" "contributors" {
    name = "contributors"
    path = "/groups/"
}

