# creating key pair for the instance in ec2
resource "aws_key_pair" "aws_tf_key_pair" {
  key_name   = "tf_key"
  public_key = file("${path.module}/id_rsa.pub")
}

# createing security group for instance
resource "aws_security_group" "aws_tf_security_group" {
  name = "tf_security_group"
  description = "Allow tls inbound traffice"

# ingress is incomming and egress is outgoing
 dynamic "ingress" {
   for_each = [22,80,443,3306,27017]
   iterator = port
   content {
     description = "exposed accessible  port"
     from_port = port.value
     to_port = port.value
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
 }
}


# creating ec2 instance
resource "aws_instance" "ec2_instance" {
  ami           = "ami-09538990a0c4fe9be"
  instance_type = "t2.micro"

  #   assigining created key pair to ec2 instance
  key_name = aws_key_pair.aws_tf_key_pair.key_name
  tags = {
    Name = "subarna_first_tf_ec2"
  }
}