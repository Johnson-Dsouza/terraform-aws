#Create a new EC2 launch configuration

resource "aws_instance" "ec2_public" {
  ami = "${var.ec2_ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  count = "${var.ec2_count}"
  security_groups =  ["${aws_security_group.ssh-security-group.id}"]
  subnet_id = element(aws_subnet.public-subnet.*.id, count.index)
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = element(var.public_instance_tags, count.index)
  }

  provisioner "file" {
    source = "./${var.key_name}.pem"
    destination = "/home/ec2-user/${var.key_name}.pem"
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("${var.key_name}.pem")
      host = self.public_ip
    }
  }

  #chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]  
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("${var.key_name}.pem")
      host = self.public_ip
    }
  }
}

#Create a new EC2 launch configuration

resource "aws_instance" "ec2_private" {
  ami = "${var.ec2_ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  count = "${var.ec2_count}"
  security_groups = [ "${aws_security_group.webserver-security-group.id}" ]
  subnet_id = element(aws_subnet.private-subnet.*.id, count.index)
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = element(var.private_instance_tags, count.index)
  }
}
