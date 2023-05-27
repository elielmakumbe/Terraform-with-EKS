# Create a Null Resource and Provisioners

resource "null_resource" "copy_ec2_keys" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance 
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("private-key/EKS-Terraform-Key.pem")
  }

  # File provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "private-key/EKS-Terraform-Key.pem"
    destination = "/tmp/EKS-Terraform-Key.pem"
  }

  # Rempte Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/EKS-Terraform-Key.pem"
    ]
  }

  #Local Exec Provisioner: local-exec provisioner (Triggered during Terraform Apply)
  provisioner "local-exec" {
    command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> created-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }
}

