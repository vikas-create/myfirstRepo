locals {
  ssh_user         = "ec2-user"
  key_name         = "ohio_key"
  private_key_path = "/etc/ansible/ohio_key.pem"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "test" {
  ami           = "ami-09246ddb00c7c4fef"
  instance_type = "t2.micro"
  key_name      = local.key_name
  tags = {
    "Name" = "tf-instance"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.test.public_ip
    }

  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.test.public_ip}, --private-key ${local.private_key_path} httpd.yml"
  }

}

output "Apache_IP" {
  value = aws_instance.test.public_ip
}