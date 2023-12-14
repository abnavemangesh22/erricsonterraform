
# resource group
resource "azurerm_resource_group" "mygr" {
  location = "East US"
  name     = "erricsongrp"
  #provider = azurerm.infrawestus
}


# network
resource "azurerm_virtual_network" "mynetwork" {
  name                = "erricson-network"
  address_space       = ["192.168.1.0/24"]
  location            = azurerm_resource_group.mygr.location
  resource_group_name = azurerm_resource_group.mygr.name
  tags = {
    envinoment = "prepod"
    project    = "crbt"
  }
}

output "mynetworkinfo" {
  value = azurerm_virtual_network.mynetwork.name
}

output "myresourcegroupinfo" {
  value = azurerm_resource_group.mygr.name
}

output "myidfornetwork" {
  value = azurerm_virtual_network.mynetwork.id
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.mymachine.public_ip_address
}


#subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "erricson-subnet"
  address_prefixes     = ["192.168.1.0/25"]
  virtual_network_name = azurerm_virtual_network.mynetwork.name
  resource_group_name  = azurerm_resource_group.mygr.name
}

# public IP
resource "azurerm_public_ip" "mypublicip" {
  name                = "erricson-public-ip"
  allocation_method   = "Dynamic"
  resource_group_name = azurerm_resource_group.mygr.name
  location            = azurerm_resource_group.mygr.location
  depends_on = [azurerm_virtual_network.mynetwork,
  azurerm_subnet.mysubnet]
}




# network interface
resource "azurerm_network_interface" "mynetworkinc" {
  name                = "erricson-network-nic"
  location            = azurerm_resource_group.mygr.location
  resource_group_name = azurerm_resource_group.mygr.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublicip.id
  }
}

# Linux Virtual Machine

resource "azurerm_linux_virtual_machine" "mymachine" {
  location            = azurerm_resource_group.mygr.location
  name                = "erricson-app-server"
  computer_name       = "erricson-app-crbt"
  size                = "Standard_F2"
  resource_group_name = azurerm_resource_group.mygr.name
  os_disk {
    name                 = "osdisk-erricson"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_username = "erricsonuser"
  admin_ssh_key {
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
    username   = "erricsonuser"
  }
  #admin_password = "Mypassword123"
  network_interface_ids = [ azurerm_network_interface.mynetworkinc.id ]
  source_image_reference {
    #publisher = "Canonical"
    #offer = "0001-com-ubuntu-server-jammy"
    #sku = "22_04-lts"
    #version = "latest"
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5"
    version   = "latest"
  }
  disable_password_authentication = true
  custom_data                     = filebase64("${path.module}/app-scripts/cloud.txt")

  tags = {
    envinoment = "prepod"
    project    = "crbt"
  }


  connection {
    host = self.public_ip_address
    user = self.admin_username
    type = "ssh"
    password = ""
    private_key =  file("${path.module}/ssh-keys/terraform-azure.pem")
  }

provisioner "file" {
  source = "ssh-keys/Mangesh"
  destination = "/tmp/Mangesh"
}


# this provisioner will get failed
provisioner "file" {
  source = "ssh-keys/terraform.txt"
  destination = "/tmp/terraform.txt"
}

provisioner "file" {
  source = "ssh-keys/terraform123.txt"
  destination = "/tmp/terraform123.txt"
  on_failure = continue
}

provisioner "file" {
  source = "ssh-keys/ansible-playbook"
  destination = "/tmp/ansible-playbook"
}

provisioner "file" {
  content = "VM Hostname: ${self.computer_name}"
  destination = "/tmp/file.log"
}

}


# File Function and terraform file64 functions:

# mkdir ssh-keys
# cd ssh-keys
# ssh-keygen  -m PEM -t rsa  -b 4096 -C "azureuser@myserver" -f terraform-azure.pem 

# ls -ltr
# terraform-azure.pem.pub -> Rename as terraform-azure.pub
# chmod 400 terraform-azure.pem


# security group creation
resource "azurerm_network_security_group" "mysecurity_group" {
  name                = "erricson-security-group"
  resource_group_name = azurerm_resource_group.mygr.name
  location            = azurerm_resource_group.mygr.location
}

# rules
resource "azurerm_network_security_rule" "myhttprule" {
  network_security_group_name = azurerm_network_security_group.mysecurity_group.name
  resource_group_name         = azurerm_resource_group.mygr.name
  name                        = "allowhttp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

# attaching the group to the subnet

resource "azurerm_subnet_network_security_group_association" "mygroupassociation" {
  subnet_id                 = azurerm_subnet.mysubnet.id
  network_security_group_id = azurerm_network_security_group.mysecurity_group.id
}

