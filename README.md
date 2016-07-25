# Quick Facts
SSH proxy IP address: 52.201.41.65
AWS account ID: 981412958133
MySQL endpoint: draftqueens.c3s7xotupned.us-east-1.rds.amazonaws.com

# Install Terraform (optional)
We use Terraform to manage our AWS resources.
Quickstart instructions are [here](https://www.terraform.io/intro/getting-started/install.html).

The most important commands are `terraform plan` and `terraform show`.
`terraform apply` is dangerous and should only be used if you know what you are
doing.

Test your Terraform install with `terraform help`.

# Get access to AWS
Ask an admin to create an IAM user for you. You will get credentials and have
to change them when you first log in. The password policy is minimum 24
characters with no other restrictions.

## Add an access key to your IAM user
Create an access key for your user through the IAM console.

Store it in a file called `.awscreds` in this directory:
```
aws_access_key_id = [key ID]
aws_secret_access_key = [access key]
```

Test your access by running `terraform plan`. The command should report 'No
changes. Infrastructure is up-to-date.'

`terraform show` spits out the entire AWS infrastructure state. It's very dense
and not good for getting a picture of the overall architecture of the VPC, but
it can be used to answer almost all questions of the form "what is the hostname
of the X server". Users are encouraged to take advantage of this property.

## Add your key to the SSH proxy
The only access into our VPC is through an SSH proxy. To get access, generate
an SSH key pair and send it to an admin; or if you are feeling adventurous, go
to "DIY SSH key adding" below.

Once your key is all set, connect to the SSH proxy:
```
$ ssh-add <private key>
$ ssh <username>@52.201.41.65
```

This SSH configuration will allow you to connect to the SSH server with
`ssh draftqueens`:

```
Host draftqueens
    HostName 52.201.41.65
    User <username>
    IdentityFile ~/.ssh/id_rsa (or whatever yours is)
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null  # suppresses bad host key warning (see below)
```

### Bad Host Key warnings
Every time a new user or key is added, the SSH proxy's host key changes. This
causes everyone to get a scary warning next time they connect. This is
expected and can be ignored.

The reason is because currently users and keys are added by terminating the
instance and creating a new one with the user and key in the new instance's
user_data. This is not ideal and we should be using a real configuration
management tool instead.

### DIY SSH key
Add your public key to `users.tf`, right below your user.

For example:
```
resource "aws_iam_user_ssh_key" "dolan-eq" {
    username = "${aws_iam_user.dolan.name}"
    encoding = "PEM"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTr06CqPPOpxuJ5DZCD9Iv/b+QukBAin5/HJu0IgPUgp3HVpoxvAzEyrvntV18GUTpIPWfbaBIAw+nCLHxHlTXWo2Ngs3mIfFLmDi452MgVg4vtYCvg70tDi2nEf9UgtHaA9fQPsdTUOT4CxyoKdJR531WEOVNwVaXk8mQxSn/gj9SiHjvgcf7yW5dfGrGbP01NO17qXp1gx/iz65LlZnmEnB8utsnpJ7pKQGZi+XpUoVAKso2nSRc/67pjVQhB7IPJ26VMqvIZsPuLLAm+nsVA4c6Ikq+afL0MuQhxQoS0VBNSR47pneWP/5EClGR4IWjC8/1Mbw4HuGER4zXyq2J dmurvihill@EQ-322.local"
}
```

In `ssh.tf`, find the "file_template" "ssh-install" resource declaration. Look
at the `vars` mapping. add new `my-name` and `my-key` variables for yourself,
matching the ones that are already there.

Then, add create-user and add-key hooks at the bottom of `ssh-setup.tpl`,
matching the variables you just declared in `ssh.tf`.

Run `terraform plan`. It should show changes to the template, a new SSH
instance, and a change to the Elastic IP. Open a pull request with your changes
and an admin will run them.

# Get access to the database

Ask an admin to create a database user for you.

The database server is not available directly; it has to be accessed through
the SSH proxy.
With the command line MySQL client this is done like this:

```bash
$ ssh -f user@ssh.example.com -L 3307:mysql.example.com:3306 -N
$ mysql -h 127.0.0.1 -P 3307
```

Tools like DataGrip have intuitive ways of configuring SQL connections through
an SSH proxy. Consult the documentation for your tool of choice.

