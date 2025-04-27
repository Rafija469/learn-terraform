provider "azurerm" {
  features {}
  subscription_id = "59eba330-2ce9-4f7a-904e-57de924d31ac"
}


resource "azurerm_virtual_machine" "test" {
  name                  = "test-vm"
  location              = "uk west"
  resource_group_name   = "project-setup-1"
  network_interface_ids = ["/subscriptions/59eba330-2ce9-4f7a-904e-57de924d31ac/resourceGroups/project-setup-1/providers/Microsoft.Network/networkInterfaces/terraform-testing"]
  vm_size               = "Standard_B2ls_v2"

   delete_os_disk_on_termination = true

  storage_image_reference {
   id="/subscriptions/59eba330-2ce9-4f7a-904e-57de924d31ac/resourceGroups/project-setup-1/providers/Microsoft.Compute/images/image-devops-practice"
  }
  storage_os_disk {
    name              = "test-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "test-vm"
    admin_username = "azuser"
    admin_password = "Marchmonth@12345"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}