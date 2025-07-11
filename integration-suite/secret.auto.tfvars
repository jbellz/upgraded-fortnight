########################################################################
# Account login information
########################################################################
btp_username = "j96n@pge.com"
btp_password = "#PonyDoughnut69"

########################################################################
# Account settings
########################################################################
globalaccount     = "pacificgasandelectriccompany-01"
region            = "us11"
subaccount_name   = "Integration-dev"
subaccount_domain = "pge-integration-dev"
# directory_id      = " "

# Set the subaccount_id to run the script in an existing subaccount, 
# keep it empty to create a new one, for that you need the global account administration role
subaccount_id = ""

#####################################################################################
# Subaccount administrators - don't add your own user here, your ID is added automatically
#####################################################################################
subaccount_admins = ["rxCa@pge.com", "SQS7@pge.com"]


#####################################################################################
# Service administrators and developers - add your ID here
#####################################################################################
service_admins = ["j96n@pge.com"]
developers     = ["j96n@pge.com"]


#####################################################################################
# Integration Provisioners - add your ID here
#####################################################################################
integration_provisioners = ["j96n@pge.com"]

#####################################################################################
# Service plans - for testing the services you can set "free" as value, the free service plan 
# is only supported for SAP BTP accounts  with the CPEA, BTPEA or Pay-as-you-go commercial model
#####################################################################################
