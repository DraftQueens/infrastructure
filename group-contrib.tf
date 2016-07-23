resource "aws_iam_group" "contributors" {
    name = "contributors"
    path = "/groups/"
}

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

resource "aws_iam_group_membership" "contributors" {
    name = "contributors"
    users = [
        "${aws_iam_user.ben.name}",
        "${aws_iam_user.eddie.name}",
        "${aws_iam_user.dolan.name}"
    ]
    group = "${aws_iam_group.contributors.name}"
}

