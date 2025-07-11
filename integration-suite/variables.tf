variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}
variable "directory_id" {
  description = "The ID of the subaccounts parent entity."
  type        = string
  default     = "IT-Core"
}
variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "My SAP subaccount"
}
variable "subaccount_id" {
  type        = string
  description = "The subaccount ID."
  default     = ""
}
variable "region" {
  type        = string
  description = "The region where the subaccount shall be created in."
  default     = "us11"
}
variable "subaccount_domain" {
  type        = string
  description = "the subdomain of the subaccount being created."
  default     = null
}

variable "subaccount_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as emergency administrators."
}
variable "service_admins" {
  type        = list(string)
  description = "Defines the users who are added to each subaccount as service administrators."
}

variable "integration_provisioners" {
  type        = list(string)
  description = "Defines the users who are added to activate the Integration Suite."
}

variable "developers" {
  type        = list(string)
  description = "Defines the colleagues who are added to services as developers."
}

variable "btp_username" {
  type        = string
  description = "SAP BTP user name"
  ## set default value to "" when using environment values for user and password
  # default     = ""
}

variable "btp_password" {
  type        = string
  description = "Password for SAP BTP user"
  sensitive   = true
  ## set default value to "" when using environment values for user and password
  # default     = ""
}
