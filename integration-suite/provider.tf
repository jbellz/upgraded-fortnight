terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~>1.14.0"
    }
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = "1.7.0"
    }
  }
}

provider "btp" {
  globalaccount = var.globalaccount
  username      = var.btp_username
  password      = var.btp_password
}
provider "cloudfoundry" {
  api_url  = "https://api.cf.us11.hana.ondemand.com"
  user     = var.btp_username
  password = var.btp_password

}