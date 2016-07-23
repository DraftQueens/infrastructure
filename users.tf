resource "aws_iam_user" "dolan" {
    name = "dolan"
    path = "/users/"
}

resource "aws_iam_user_ssh_key" "dolan-eq" {
    username = "${aws_iam_user.dolan.name}"
    encoding = "PEM"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTr06CqPPOpxuJ5DZCD9Iv/b+QukBAin5/HJu0IgPUgp3HVpoxvAzEyrvntV18GUTpIPWfbaBIAw+nCLHxHlTXWo2Ngs3mIfFLmDi452MgVg4vtYCvg70tDi2nEf9UgtHaA9fQPsdTUOT4CxyoKdJR531WEOVNwVaXk8mQxSn/gj9SiHjvgcf7yW5dfGrGbP01NO17qXp1gx/iz65LlZnmEnB8utsnpJ7pKQGZi+XpUoVAKso2nSRc/67pjVQhB7IPJ26VMqvIZsPuLLAm+nsVA4c6Ikq+afL0MuQhxQoS0VBNSR47pneWP/5EClGR4IWjC8/1Mbw4HuGER4zXyq2J dmurvihill@EQ-322.local"
}

resource "aws_iam_user" "ben" {
    name = "ben"
    path = "/users/"
}

resource "aws_iam_user" "eddie" {
    name = "eddie"
    path = "/users/"
}

