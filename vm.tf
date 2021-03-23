# Define common EC2 the private subnet


resource "aws_instance" "app1" {
   ami  = var.ami
   instance_type = "t2.nano"
   key_name = aws_key_pair.deployer.id
   subnet_id = var.private-subnet1
   vpc_security_group_ids = [aws_security_group.public.id]
   associate_public_ip_address = true

   connection {
    type = "ssh"
    user        = "ubuntu"
    private_key = file("pri.pem")
    host = aws_instance.app1.public_ip
  }
   
   provisioner "file" {
    source      = "go.sh"
    destination = "/tmp/go.sh"
  }
  provisioner "file" {
    source      = "web.go"
    destination = "/home/ubuntu/web.go"
  }

   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/go.sh",
      "bash /tmp/go.sh",
      "/home/ubuntu/.go/bin/go build /home/ubuntu/web.go",
      "/usr/bin/nohup /home/ubuntu/web > /dev/null 2>&1 &",
    ]
  } 


}

resource "aws_instance" "app2" {
   ami  = var.ami
   instance_type = "t2.nano"
   key_name = aws_key_pair.deployer.id
   subnet_id = var.private-subnet2
   vpc_security_group_ids = [aws_security_group.public.id]
   associate_public_ip_address = true

   connection {
    type = "ssh"
    user        = "ubuntu"
    private_key = file("pri.pem")
    host = aws_instance.app2.public_ip
  }

   provisioner "file" {
    source      = "go.sh"
    destination = "/tmp/go.sh"
  }
  provisioner "file" {
    source      = "web.go"
    destination = "/home/ubuntu/web.go"
  }

   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/go.sh",
      "bash /tmp/go.sh",
    ]
  }


}
