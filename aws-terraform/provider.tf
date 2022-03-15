provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAQ64RRADDZTHZ4ZWD"
  secret_key = "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"
}

# Create a VPC
resource "aws_vpc" "myVpc" {
  cidr_block = "10.0.0.0/16"
}
# internet gatway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVpc.id
  tags = {
    Name = "main"
  }
}

#subnet
resource "aws_subnet" "mySubnet" {
  vpc_id     = aws_vpc.myVpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnet"
  }
}


# Route table
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.myVpc.id

  #   route {
  #     cidr_block = "10.0.1.0/24"
  #     gateway_id = aws_internet_gateway.example.id
  #   }

  #   route {
  #     ipv6_cidr_block        = "::/0"
  #     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #   }

  tags = {
    Name = "example"
  }
}
#route

resource "aws_route" "r" {
  route_table_id         = "aws_rotue_table.example.id"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.example]
}


#security group

resource "aws_security_group" "sg" {
  name        = "Allow_all_trafic"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myVpc.id

  ingress {
    description      = "All traffic"
    from_port        = 0 #all port
    to_port          = 0 #All port
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = null
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = null
  }

  tags = {
    Name = "All traffic"
  }
}

##### Route Table Association ##############
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mySubnet.id
  route_table_id = aws_route_table.example.id
}



#########  EC2  instance #############


resource "aws_instance" "linux" {
  ami           = "ami-0e7a875609d14906f"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mySubnet.id

}

