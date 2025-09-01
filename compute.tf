locals {
  allowed_instance_types = ["t2.micro", "t3.micro"]

}

data "aws_ami" "ubuntu" { # external Data source we're fetching data from 
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}
resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.this[0].id

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  tags = {
    CostCenter = "1234"
  }

}
# With postconditions you can reference data within the resource block
# With preconditions you cannot reference data within the resource block. You cannot use self objects.


