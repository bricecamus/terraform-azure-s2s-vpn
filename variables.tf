variable "subscription_id" {
  type        = string
  description = "ID of the Azure subscriptions used"
}

variable "location" {
  type        = string
  description = "Azure location name used (input example: Canada East)"
}

variable "vn_address_space" {
  type        = list(string)
  description = "Virtual Network address space (input example: 172.16.0.0/16)"
}

variable "vn_subnet" {
  type        = list(string)
  description = "Subnet used by the Azure Virtual Network (input example: 172.16.1.0/24)"
}

variable "lng_gateway_adress" {
  type        = string
  description = "Public IP address of your firewall"
}

variable "lng_address_space" {
  type        = list(string)
  description = "Local Network Gateway address space aka IP range you use in your local network (input example: 10.0.0.0/8)"
}

variable "shared_key" {
  type        = string
  description = "Shared key configured in your firewall VPN IPSec configuration"
}