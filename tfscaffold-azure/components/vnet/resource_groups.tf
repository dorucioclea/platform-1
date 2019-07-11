/*
    Place all resource groups for the vnet in this file.
*/
resource "azurerm_resource_group" "vnet" {
  name     = "${var.project}-vnet-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}