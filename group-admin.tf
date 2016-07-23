# ADMIN GROUP
resource "aws_iam_group" "administrators" {
    name = "administrators"
    path = "/groups/"
}

resource "aws_iam_policy_attachment" "administrators" {
    name = "admin access"
    groups = ["${aws_iam_group.administrators.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_membership" "administrators" {
    name = "administrators"
    users = ["${aws_iam_user.dolan.name}"]
    group = "${aws_iam_group.administrators.name}"
}

