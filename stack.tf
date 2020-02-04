provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_security_group" "security-group" {
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = "88.156.143.49/32"
  }

  tags = {
    Name = "allow only Arturo"
  }
}

resource "aws_iam_role" "name" {
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow"
        "Principal": {
          "Service": [
            "ec2.amazonaws.com"
          ]
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF

  

}


resource "aws_instance" "main" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}

