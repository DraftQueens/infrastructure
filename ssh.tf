resource "aws_eip" "ssh" {
    vpc = true
    instance = "${aws_instance.ssh.id}"
}

resource "aws_instance" "ssh" {
    lifecycle {
        create_before_destroy = true
    }
    ami = "ami-2d39803a"  # ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-20160627 
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.admin.key_name}"
    vpc_security_group_ids = [
      "${aws_security_group.ssh.id}",
      "${aws_security_group.vpc-dest.id}"
    ]
    subnet_id = "${aws_subnet.draftqueens-1b.id}"
    tags {
        Name = "ssh"
    }
    user_data = "${template_file.ssh-install.rendered}"
}

resource "aws_security_group" "ssh" {
    name = "ssh"
    description = "public-facing SSH"
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        from_port = 22
        to_port = 22
    }
    vpc_id = "${aws_vpc.draftqueens.id}"
    tags {
        Name = "ssh"
    }
}

resource "template_file" "ssh-install" {
    template = "${file("ssh-install.tpl")}"

    vars {
        dolan-name = "${aws_iam_user.dolan.name}"
        ben-name = "${aws_iam_user.ben.name}"
        eddie-name = "${aws_iam_user.eddie.name}"
        dolan-key = "${aws_iam_user_ssh_key.dolan-eq.public_key}"
    }
}

