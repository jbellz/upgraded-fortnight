resource "btp_subaccount" "integration_suite" {
  name         = var.subaccount_name
  subdomain    = var.subaccount_domain
  region       = var.region
  beta_enabled = false
  description  = "Integration Suite subaccount for managing API's and Integration flows"
  usage = "NOT_USED_FOR_PRODUCTION"
}

resource "btp_subaccount_trust_configuration" "integration_suite_trust_configuration" {
  subaccount_id = btp_subaccount.integration_suite.id
  identity_provider = "afsae6u9p.accounts.ondemand.com"
  description = "PGE custom idp for business users"
  auto_create_shadow_users = true
  available_for_user_logon = true
  link_text = "PGE Logon"
  name = "PG&E Custom IAS"
  domain = "afsae6u9p.accounts.ondemand.com"
}

data "btp_subaccount_trust_configuration" "integration_suite_trust_configuration" {
  subaccount_id = btp_subaccount.integration_suite.id
  origin = btp_subaccount_trust_configuration.integration_suite_trust_configuration.origin
}

resource "btp_subaccount_security_settings" "integration_suite_security_settings" {
  subaccount_id = btp_subaccount.integration_suite.id
  default_identity_provider = "sap.custom"
  access_token_validity = 1800
  refresh_token_validity = 1800
  treat_users_with_same_email_as_same_user = true
}

resource "btp_subaccount_entitlement" "cf_runtime_memory" {
  subaccount_id = btp_subaccount.integration_suite.id
  service_name = "APPLICATION_RUNTIME"
  plan_name = "MEMORY"
  amount = 50
  depends_on = [ btp_subaccount.integration_suite ]
}

resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id = btp_subaccount.integration_suite.id
  name = "integration-dev"
  environment_type = "cloudfoundry"
  service_name = "cloudfoundry"
  plan_name = "standard"
  parameters = jsonencode({
    instance_name = "integration-dev"
  })
  timeouts = {
    create = "1m"
    update = "1m"
    delete = "1m"
  }
  depends_on = [ btp_subaccount_entitlement.cf_runtime_memory ]
}

locals {
  cf_org_id = jsondecode(btp_subaccount_environment_instance.cloudfoundry.labels)["Org ID"]
}

resource "cloudfoundry_space" "dev" {
  org = local.cf_org_id
  name = "dev"
}

resource "btp_subaccount_entitlement" "integration_suite" {
  subaccount_id = btp_subaccount.integration_suite.id
  service_name = "integrationsuite"
  plan_name = "enterprise_agreement"
  amount = 1
  depends_on = [ btp_subaccount.integration_suite ]
}

resource "btp_subaccount_subscription" "integration_suite" {
  subaccount_id = btp_subaccount.integration_suite.id
  app_name = "integrationsuite"
  plan_name = "enterprise_agreement"
  depends_on = [ btp_subaccount_entitlement.integration_suite ]
}

resource "btp_subaccount_role_collection_assignment" "integration_provisioners" {
  for_each             = toset(var.integration_provisioners)
  subaccount_id        = btp_subaccount.integration_suite.id
  role_collection_name = "Integration_Provisioner"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.integration_suite]
}
resource "cloudfoundry_space_role" "space_developer" {
  for_each   = toset(var.space_managers)
  username   = each.value
  type       = "space_developer"
  space      = cloudfoundry_space.dev.id
  origin     = "sap.ids"
  depends_on = [cloudfoundry_org_role.org_manager]
}