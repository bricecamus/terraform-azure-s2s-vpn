resource "azurerm_resource_group" "rg_vpn_s2s" {
  name     = "rg_vpn_s2s"
  location = var.location
}

resource "azurerm_virtual_network" "vpn_s2s_vn" {
  name                = "vpn_s2s_vn"
  location            = azurerm_resource_group.rg_vpn_s2s.location
  resource_group_name = azurerm_resource_group.rg_vpn_s2s.name
  address_space       = var.vn_address_space
}

resource "azurerm_subnet" "vpn_s2s_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg_vpn_s2s.name
  virtual_network_name = azurerm_virtual_network.vpn_s2s_vn.name
  address_prefixes     = var.vn_subnet
}

resource "azurerm_public_ip" "vpn_s2s_public_ip" {
  name                = "vpn_s2s_public_ip"
  location            = azurerm_resource_group.rg_vpn_s2s.location
  resource_group_name = azurerm_resource_group.rg_vpn_s2s.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpn_s2s_vn_gateway" {
  name                = "vpn_s2s_vn_gateway"
  location            = azurerm_resource_group.rg_vpn_s2s.location
  resource_group_name = azurerm_resource_group.rg_vpn_s2s.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn_s2s_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpn_s2s_subnet.id
  }
}

resource "azurerm_local_network_gateway" "vpn_s2s_local_gateway" {
  name                = "vpn_s2s_local_gateway"
  location            = azurerm_resource_group.rg_vpn_s2s.location
  resource_group_name = azurerm_resource_group.rg_vpn_s2s.name
  gateway_address     = var.lng_gateway_address
  address_space       = var.lng_address_space
}

resource "azurerm_virtual_network_gateway_connection" "vpn_s2s_connection" {
  name                       = "vpn_s2s_connection"
  location                   = azurerm_resource_group.rg_vpn_s2s.location
  resource_group_name        = azurerm_resource_group.rg_vpn_s2s.name
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_s2s_vn_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.vpn_s2s_local_gateway.id
  shared_key                 = var.shared_key
}