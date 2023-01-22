variable "subscription_id" {
  type        = string
  description = "ID of the Azure subscriptions used"
}

variable "location" {
  type        = string
  description = "Azure location name used"
}

variable "vn_address_space" {
  type        = list(string)
  description = "Virtual Network address space"
}

variable "vn_subnet" {
  type        = list(string)
  description = "Subnet used by the Azure Virtual Network"
}

variable "lng_gateway_adress" {
  type        = string
  description = "WAN interface IP address of your firewall"
}

variable "lng_address_space" {
  type        = list(string)
  description = "Local Network Gateway address space (IP range you use in your local network)"
}

variable "shared_key" {
  type        = string
  description = "Shared key configured in your firewall VPN IPSec configuration"
}