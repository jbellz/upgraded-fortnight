variable "globalaccount" {
  description = "Subdomain of the global account"
  type        = string
}

variable "cf_landscape_label" {
  description = "Label of the Cloud Foundry landscape"
  type        = string
  default     = "us11"
  validation {
    condition     = contains(["us11", "us10"], var.cf_landscape_label)
    error_message = "Landscape must be one of us11 or us10"
  }
}

variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "My SAP subaccount"
}
variable "subaccount_id" {
  description = "The ID of the subaccount"
  type        = string
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

variable "space_id" {
  description = "The ID of the Cloud Foudnry space"
  type        = string
}

variable "pi_admins" {
  description = "List of PI admins"
  type        = list(string)
  default     = []
}

variable "pi_business_experts" {
  description = "List of PI Business Experts"
  type        = list(string)
  default     = []
}

variable "pi_integration_developers" {
  description = "List of PI integration developers"
  type        = list(string)
  default     = []
}

variable "pi_readonly" {
  description = "List of PI Read Only users"
  type        = list(string)
  default     = []
}
variable "btp_username" {
  type        = string
  description = "SAP BTP user name"
  ## set default value to "" when using environment values for user and password
  default     = ""
}

variable "btp_password" {
  type        = string
  description = "Password for SAP BTP user"
  sensitive   = true
  ## set default value to "" when using environment values for user and password
  default     = ""
}