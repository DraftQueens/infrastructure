resource "aws_db_instance" "draftqueens" {
    allocated_storage = 10
    engine = "mysql"
    engine_version = "5.7.11"
    identifier = "draftqueens"
    instance_class = "db.t2.micro"
    storage_type = "gp2"
    username = "root"
    password = "rootroot"
    publicly_accessible = true
    vpc_security_group_ids = ["${aws_security_group.db.id}"]
    db_subnet_group_name = "${aws_db_subnet_group.draftqueens.name}"
    storage_encrypted = false
}

resource "aws_db_subnet_group" "draftqueens" {
    name = "draftqueens"
    description = "our RDS subnet group"
    subnet_ids = [
        "${aws_subnet.draftqueens-1b.id}", 
        "${aws_subnet.draftqueens-1c.id}",
        "${aws_subnet.draftqueens-1d.id}"
    ]
}

resource "aws_security_group" "db" {
    name = "db"
    description = "database access"
    vpc_id = "${aws_vpc.draftqueens.id}"
    ingress {
        cidr_blocks = ["${aws_vpc.draftqueens.cidr_block}"]
        protocol = "tcp"
        from_port = 3306
        to_port = 3306
    }
    egress {
        cidr_blocks = ["${aws_vpc.draftqueens.cidr_block}"]
        protocol = "tcp"
        from_port = 3306
        to_port = 3306
    }
    tags {
        Name = "db"
    }
}

