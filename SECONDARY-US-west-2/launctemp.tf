data "aws_ami" "example" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.18-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_launch_template" "frontend" {
  name                   = "frontend-terraform"
  description            = "frontend-terraform"
  image_id               = data.aws_ami.example.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
  key_name               = "sam-west"
  user_data              = filebase64("${path.module}/frontend-lt.sh")
  update_default_version = true

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "frontend-terraform"
    }
  }
}

###################################################################################

data "aws_ami" "example1" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.18-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_launch_template" "backend" {
  name                   = "backend-terraform"
  description            = "backend-terraform"
  image_id               = data.aws_ami.example1.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  key_name               = "sam-west"
  user_data              = filebase64("${path.module}/backend-lt.sh")
  update_default_version = true

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "backend-terraform"
    }
  }
}