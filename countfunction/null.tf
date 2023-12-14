

resource "null_resource" "sync-app-crbt" {
  depends_on = [ time_sleep.wait90sec ]
  triggers = {
    always-update = timestamp()
  }

connection {
    host        = data.azurerm_public_ip.*.pip.ip_address
    user        = "erricsonuser"
    type        = "ssh"
    password    = ""
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }

  provisioner "file" {
    source      = "ssh-keys/temp.sh"
    destination = "/tmp/temp.sh"
  }

  provisioner "file" {
    source      = "ssh-keys/mangeshweb.html"
    destination = "/tmp/mangeshweb.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sleep 20",
      "sudo sh /tmp/temp.sh",
      "sudo cp /tmp/mangeshweb.html /var/www/html"
    ]
  }
}

resource "time_sleep" "wait90sec" {
  depends_on = [ azurerm_linux_virtual_machine.mymachine ] 
  create_duration = "90s"
}

