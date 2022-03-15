#ssh-key value pair

resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub")
}

## Creating security group

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  ## dynamic security group

  dynamic "ingress" {
    # for_each=[22,80,443,3306,27017]
      or_each= var.ports
    iterator = port
    content{
 
    description      = "TLS from VPC"
    from_port        = port.value
    to_port          = port.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


 
  # ingress {
  #   description      = "TLS from VPC"
  #   from_port        = 443
  #   to_port          = 443
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
   
  # }

  # ingress {
  #   description      = "TLS from VPC"
  #   from_port        = 80
  #   to_port          = 80
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
   
  # }
  #   ingress {
  #   description      = "TLS from VPC"
  #   from_port        = 3306
  #   to_port          = 3306
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
   
  # }


  
  tags = {
    Name = "allow_tls"
  }
}

# output "sequrityGroupDetails" {
#     value = "${aws_security_group.allow_tls.id}"
# }

#instance create

resource "aws_instance" "web" {
  # ami           = "ami-0851b76e8b1bce90b"
  ami = "${var.image_id}"
  #instance_type = "t2.micro"
  instance_type = "${var.instance_type}"
    key_name = "${aws_key_pair.key-tf.key_name}"
    vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "1st-tf-instance"
  }
}

