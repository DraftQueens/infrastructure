provider "aws" {
    region = "us-east-1"
    allowed_account_ids = ["981412958133"]
    shared_credentials_file = ".awscreds"
}

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

resource "aws_iam_user" "dolan" {
    name = "dolan"
    path = "/users/"
}

resource "aws_iam_user_ssh_key" "dolan-eq" {
    username = "${aws_iam_user.dolan.name}"
    encoding = "PEM"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTr06CqPPOpxuJ5DZCD9Iv/b+QukBAin5/HJu0IgPUgp3HVpoxvAzEyrvntV18GUTpIPWfbaBIAw+nCLHxHlTXWo2Ngs3mIfFLmDi452MgVg4vtYCvg70tDi2nEf9UgtHaA9fQPsdTUOT4CxyoKdJR531WEOVNwVaXk8mQxSn/gj9SiHjvgcf7yW5dfGrGbP01NO17qXp1gx/iz65LlZnmEnB8utsnpJ7pKQGZi+XpUoVAKso2nSRc/67pjVQhB7IPJ26VMqvIZsPuLLAm+nsVA4c6Ikq+afL0MuQhxQoS0VBNSR47pneWP/5EClGR4IWjC8/1Mbw4HuGER4zXyq2J dmurvihill@EQ-322.local"
}

