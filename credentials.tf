provider "aws" {
    region = "us-east-1"
    allowed_account_ids = ["981412958133"]
    shared_credentials_file = ".awscreds"
}

resource "aws_key_pair" "admin" {
    key_name = "admin"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/JhEXr8fiTiRRJlZlPteL0KvaOMaM+0WqYxEFHCbEOVtcWmakVX/LzNPBkGtczOYTVc3Nuin3UhE2kToI/wgkS6ksby/oL8+C5RrNb/4IINtoTwgkMVchu0aFdwfAvizvTscQjhHVLAZAXx7T01uirl4ckXuoKTQbASdTKWJSmr2R040MVRNZMwvLSiGUw5CVMkL5rGq0dGH1i1TxMRSfjmMdkfdfmQl9OUkSjizfTeDERZsdj3QAXhXjXwA5mlY0FM/sqB7tCqpzZQm3P6eW8FShlQONLdkCTnAiquYRHtKfh8sI7E9tUZ5ffG0wLDhPaGG6+deEoNc6DVNxH+td dmurvihill@EQ-322.hsd1.ma.comcast.net"
}

