resource "aws_vpc" "draftqueens" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
        Name = "draftqueens"
    }
}

resource "aws_internet_gateway" "draftqueens" {
    vpc_id = "${aws_vpc.draftqueens.id}"
    tags {
        Name = "draftqueens"
    }
}

resource "aws_security_group" "vpc-dest" {
    name = "vpc-dest"
    description = "outbound inside VPC"
    egress {
        cidr_blocks = ["${aws_vpc.draftqueens.cidr_block}"]
        protocol = "tcp"
        from_port = 0
        to_port = 65535
    }
    vpc_id = "${aws_vpc.draftqueens.id}"
    tags {
        Name = "vpc-dest"
    }
}

# SUBNETS
resource "aws_subnet" "draftqueens-1b" {
    availability_zone = "us-east-1b"
    cidr_block = "10.0.0.0/24"
    vpc_id = "${aws_vpc.draftqueens.id}"
    map_public_ip_on_launch = true
    tags {
        Name = "draftqueens-1b"
    }
}

resource "aws_subnet" "draftqueens-1c" {
    availability_zone = "us-east-1c"
    cidr_block = "10.0.1.0/24"
    vpc_id = "${aws_vpc.draftqueens.id}"
    map_public_ip_on_launch = true
    tags {
        Name = "draftqueens-1c"
    }
}

resource "aws_subnet" "draftqueens-1d" {
    availability_zone = "us-east-1d"
    cidr_block = "10.0.2.0/24"
    vpc_id = "${aws_vpc.draftqueens.id}"
    map_public_ip_on_launch = true
    tags {
        Name = "draftqueens-1d"
    }
}

# ROUTE TABLE
resource "aws_route_table" "draftqueens" {
    vpc_id = "${aws_vpc.draftqueens.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.draftqueens.id}"
    }
    tags {
        Name = "draftqueens"
    }
}

resource "aws_route_table_association" "draftqueens-1b" {
    subnet_id = "${aws_subnet.draftqueens-1b.id}"
    route_table_id = "${aws_route_table.draftqueens.id}"
}

resource "aws_route_table_association" "draftqueens-1c" {
    subnet_id = "${aws_subnet.draftqueens-1c.id}"
    route_table_id = "${aws_route_table.draftqueens.id}"
}

resource "aws_route_table_association" "draftqueens-1d" {
    subnet_id = "${aws_subnet.draftqueens-1d.id}"
    route_table_id = "${aws_route_table.draftqueens.id}"
}

