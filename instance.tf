# creating key pair for the instance in ec2
resource "aws_key_pair" "aws_tf_key_pair" {
  key_name   = "tf_key"
  public_key = file("${path.module}/id_rsa.pub")
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