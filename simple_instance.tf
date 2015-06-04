variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "ap-northeast-1"
}

resource "aws_iam_instance_profile" "takasing_tf" {
  name = "${aws_iam_role.takasing_tf.name}"
  roles = ["${aws_iam_role.takasing_tf.name}"]
}

resource "aws_iam_role" "takasing_tf" {
  name = "takasing-tf"
  path = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {"AWS": "*"},
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "takasing_tf_policy" {
  name = "takasing-tf-policy"
  role = "${aws_iam_role.takasing_tf.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudwatch:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "autoscaling:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_instance" "tf_instance" {
  ami = "ami-9cc1119c"
  availability_zone = "ap-northeast-1a"
  instance_type = "t2.micro"
  key_name = "toyo-tokyo"
  tags {
    Name = "terraformers"
  }
  iam_instance_profile = "${aws_iam_instance_profile.takasing_tf.name}"
}
