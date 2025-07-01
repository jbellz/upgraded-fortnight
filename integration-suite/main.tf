resource "btp_subaccount" "integration_suite" {
  name         = var.subaccount_name
  subdomain    = var.subaccount_domain
  region       = var.region
  beta_enabled = false
  description  = "Integration Suite subaccount for managing API's and Integration flows"
}