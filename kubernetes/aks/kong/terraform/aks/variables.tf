variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "kong-resource-group"
}

variable "location" {
  description = "Azure region"
  default     = "East US 2"
}

variable "node_size" {
  description = "Size of the VM"
  default     = "Standard_D2_v2"
}

variable "subscription_id" {
  type        = string
  description = "The ID of the Azure subscription"
  default     = "7703e08d-9dff-445d-ab6b-6af170a0997e"
}
