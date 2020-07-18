# Test-agilemonkeys
A short test for Agile Monkeys <img src="https://raw.githubusercontent.com/iampavangandhi/iampavangandhi/master/gifs/Hi.gif" width="30px"></h2>

<a href="https://www.linkedin.com/in/fppalumbo/">
  <img align="left" alt="Ajay's Linkdein" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/linkedin.svg" />
</a>
<a href="https://github.com/fabiopalumbo">
  <img align="left" alt="Ajay's Github" width="22px" src="https://cdn.jsdelivr.net/npm/simple-icons@v3/icons/github.svg" />
</a>
<br />
<img align="right" alt="GIF" src="https://media.giphy.com/media/13HgwGsXF0aiGY/giphy.gif" />

### I am Fabio Palumbo
- CKA 
- Solution Architect AWS
- Currently working on Azure 204 Certification
- I love to learn and contribute in any and every possible way.

⭐️ From [fabiopalumbo](https://https://github.com/fabiopalumbo/)



--------------------------------------------------------------------------------------------------------------------------------------------

## Index
* [Current Architecture](#current-architecture)
* [Current Diagram](#current-diagram)
* [Questions](#current-questions)
* [Proposed Architecture](#proposed-architecture)
* [CICD - Jenkins](#jenkins)
* [Observability](#observability)
* [Permissions](#permissions)
* [Migration](#migration)
* [Budget](#budget)
* [Next Steps](#next-steps)


--------------------------------------------------------------------------------------------------------------------------------------------

## Current Architecture.
<details>
<summary>Test Details</summary>

```
Let’s imagine that a Bank has a monolithic architecture to handle the enrollment for new credit cards.
A potential customer will enter a bunch of data through some online forms.
Once a day there will be a batch processing job that will process all this
data (The job will trigger a monolithic application that extracts the day’s
data and run the following tasks) The job will trigger a monolith service).

• It will verify if it’s an existing customer and if it is, it will verify any
potential loans or red flags in case the customer is not eligible for a
new credit card.
• It will verify the customer’s identity. We reach an external API (e.g.
Equifax) to verify all the provided details are accurate and also verify
if there is any red flag.
• It will calculate the amount limit assigned for the credit card. It will
also auto-generate a new Credit Card number so the customer can
start using it right away until the actual credit card is received.
All the data is currently persisted on an on-premise Oracle DB. This DB
holds all the personal data the user inputs in the forms and also additional
data that will help to calculate his/her credit rating.

## The Goal
As a company-wide initiative, we’ve been asked to
1. Migrate all our systems to Azure cloud
2. The company is shifting to event-driven architecture with
microservices

## The Test
This test will mix some designs (text and diagrams are expected) and
some coding. We are absolutely not aiming to build this system. We just
want to test some relevant points we’ll explicitly point out.
1. Given the 2 goals we mentioned in the previous section, imagine a
new architecture including text, diagrams, and any other useful
resource. Give special attention how to handle exceptions if the job
stops for any reason. How do we recover? How will the deployment
process will be? Also, think about permissions, how are we going the
Azure resources permissions?
2. How are you going to handle the migration of data? Design a
strategy (maybe using cloud resources o anything else?) and tell us
about it.
3. Let’s assume the current DB is a traditional Oracle relational DB.
Write all the necessary scripts to migrate this data to a new DB in
Azure. There are several options. Please explain which one you
choose and why.
4. Given the new architecture in Azure you designed let’s assume we’ll
provision new resources through Terraform. Build some of the infra
(let’s discuss which parts will be more relevant) with Terraform and
deploy it.
5. What kind of monitoring would be relevant to add? What kind of
resources would be helpful to achieve this?
We are expecting:
1. A detailed explained for each step
2. The reasons to choose each resource in Azure.
3. Details on how those resources work. 
```
</details>

## Current Diagram
![alt text](/Images/them_current_Arch.png "Azure Current diagram")

## Questions
<details>
<summary>User / Permissions Migration</summary>

```
Are the users using auth/authentication federated service? SSO auth?

User’s apply through filling out forms without the necessity of creating an account with the bank (it is open to anyone) so there should be no auth involved.
In the future we might incorporate federated auth that will allow us to fill out some information that we currently request to users. So any prep work for the future would be great.
```
</details>
<details>
<summary>Data Migration</summary>
  
```
*Are we planning to migrate Oracle “As is” with license
Yes. However, we are open to suggestions if we could cut cost but keeping the performance and reliability.

*Are there any restrictions on the application’s geographic storage location?
Due to the regulations of the country in which the bank is located (assume a EU country) the data layer must be physically stored in the EU and we need to know where exactly data is located at any point in time.

Is the data/application subject to robust regulatory protocols?
Yes, since we are dealing with sensitive data, we have to comply with EU regulations, such as GDPR and also comply with financial rules
```
</details>
<details>
<summary>Interface System Constraints</summary>
  
```
The External API call to Equifax have any constrains? concurrency? limits?
Equifax has a rate limit of 100 API request per second. This service is widely consumed by other companies and services.

Is the online form storing data in the db directly using the monolithic service?
Yes

Is the application run in a certain os system?
The application currently runs under Red Hat Enterprise Linux

Is the Amount calculator process and VerifyClient process in the same monolithic architecture?
Nope, they are part of the services available in the on-premise infrastructure.

Is the application run in un monolithic process or is an instance with several proceses in it?
Currently, it is a monolithic process in a machine with many other processes happening. However, due to the expected growth of the company in the following year, we are considering more efficient and scalable workflows.

Is the online form static content? and of our ownership?
The online form has static content and it is owned by us.
```
</details>
<details>
<summary>Budget</summary>
  
```
Do we have budget limitations?
As many other financial enterprises, we are heavily investing in technology and budget should not be an issue. However, it would be great to have some realistic figure on the expected cost per month once we move to the cloud.
```
</details>
<details>
<summary>Application design</summary>
  
```

Do we have the need of a high available System?
Yes, since the enrollment for credit cards can happen at any time, we cannot afford missing a potential customer due to our technology stack

Will we gather metrics? Application side, service mesh?
We should gather metrics, on the application side we should be able at least to tell how many people entered the site, filled out the form, or left, etc.
On the server side we should be monitoring load and performance and be proactive.

Do we currently use any kind of Automation CICD tool? Code quality check?
CICD Jenkins/CircleCI, SonarQube, Dependabot, we also do testing (unit testing, integration testing, ui testing), linting, we also run some pen testing tools to avoid potential security breaches due to malicious code.
```
</details>

# Proposed Architecture
![alt text](/Images/them_new_architecture.png "Proposed Azure diagram")

## Requirement
* Azure with a Visual Studio Subscription
* Jenkins
* Terraform => v0.12
* AZ cli --> (curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash)
* For Terratest --> Go v0.13

### Constrains
* Blob Storage for Terraform State
* Due to GDPR compliance we will store our data resources under in eu-west region
* Vm server should be RHEL due to application requirements

(#jenkins)## Jenkins Automation
![alt text](/Images/them_terratest.png "Jenkins Automation")

## Terratest


<details>
<summary>Summary</summary>
  
```

------------------------------------------------------------------------
------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # azurerm_network_security_group.devops will be created
  + resource "azurerm_network_security_group" "devops" {
      + id                  = (known after apply)
      + location            = "ireland"
      + name                = "demo-NSG"
      + resource_group_name = "dev-demo-RG"
      + security_rule       = (known after apply)
    }

  # azurerm_resource_group.devops will be created
  + resource "azurerm_resource_group" "devops" {
      + id       = (known after apply)
      + location = "ireland"
      + name     = "dev-demo-RG"
    }

  # azurerm_route_table.devops will be created
  + resource "azurerm_route_table" "devops" {
      + disable_bgp_route_propagation = false
      + id                            = (known after apply)
      + location                      = "ireland"
      + name                          = "demo-dev-route"
      + resource_group_name           = "dev-demo-RG"
      + route                         = [
          + {
              + address_prefix         = "10.0.0.0/16"
              + name                   = "route1"
              + next_hop_in_ip_address = null
              + next_hop_type          = "vnetlocal"
            },
        ]
      + subnets                       = (known after apply)
      + tags                          = {
          + "environment" = "dev"
        }
    }

  # azurerm_storage_account.devops will be created
  + resource "azurerm_storage_account" "devops" {
      + access_tier                      = (known after apply)
      + account_kind                     = "StorageV2"
      + account_replication_type         = "LRS"
      + account_tier                     = "Standard"
      + allow_blob_public_access         = true
      + enable_https_traffic_only        = true
      + id                               = (known after apply)
      + is_hns_enabled                   = false
      + location                         = "ireland"
      + name                             = (known after apply)
      + primary_access_key               = (sensitive value)
      + primary_blob_connection_string   = (sensitive value)
      + primary_blob_endpoint            = (known after apply)
      + primary_blob_host                = (known after apply)
      + primary_connection_string        = (sensitive value)
      + primary_dfs_endpoint             = (known after apply)
      + primary_dfs_host                 = (known after apply)
      + primary_file_endpoint            = (known after apply)
      + primary_file_host                = (known after apply)
      + primary_location                 = (known after apply)
      + primary_queue_endpoint           = (known after apply)
      + primary_queue_host               = (known after apply)
      + primary_table_endpoint           = (known after apply)
      + primary_table_host               = (known after apply)
      + primary_web_endpoint             = (known after apply)
      + primary_web_host                 = (known after apply)
      + resource_group_name              = "dev-demo-RG"
      + secondary_access_key             = (sensitive value)
      + secondary_blob_connection_string = (sensitive value)
      + secondary_blob_endpoint          = (known after apply)
      + secondary_blob_host              = (known after apply)
      + secondary_connection_string      = (sensitive value)
      + secondary_dfs_endpoint           = (known after apply)
      + secondary_dfs_host               = (known after apply)
      + secondary_file_endpoint          = (known after apply)
      + secondary_file_host              = (known after apply)
      + secondary_location               = (known after apply)
      + secondary_queue_endpoint         = (known after apply)
      + secondary_queue_host             = (known after apply)
      + secondary_table_endpoint         = (known after apply)
      + secondary_table_host             = (known after apply)
      + secondary_web_endpoint           = (known after apply)
      + secondary_web_host               = (known after apply)
      + tags                             = {
          + "environment" = "dev"
        }

      + blob_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }
    }

  # azurerm_subnet.devopsapp will be created
  + resource "azurerm_subnet" "devopsapp" {
      + address_prefix                                 = "10.0.1.0/24"
      + address_prefixes                               = (known after apply)
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "demo-dev-app-subnet"
      + resource_group_name                            = "dev-demo-RG"
      + virtual_network_name                           = "demo-VNET"
    }

  # azurerm_subnet.devopsdb will be created
  + resource "azurerm_subnet" "devopsdb" {
      + address_prefix                                 = "10.0.3.0/24"
      + address_prefixes                               = (known after apply)
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "demo-dev-db-subnet"
      + resource_group_name                            = "dev-demo-RG"
      + virtual_network_name                           = "demo-VNET"
    }

  # azurerm_subnet.devopspublic will be created
  + resource "azurerm_subnet" "devopspublic" {
      + address_prefix                                 = "10.0.4.0/24"
      + address_prefixes                               = (known after apply)
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "demo-dev-public-subnet"
      + resource_group_name                            = "dev-demo-RG"
      + virtual_network_name                           = "demo-VNET"
    }

  # azurerm_subnet.devopsweb will be created
  + resource "azurerm_subnet" "devopsweb" {
      + address_prefix                                 = "10.0.2.0/24"
      + address_prefixes                               = (known after apply)
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "demo-dev-web-subnet"
      + resource_group_name                            = "dev-demo-RG"
      + virtual_network_name                           = "demo-VNET"
    }

  # azurerm_virtual_network.devops will be created
  + resource "azurerm_virtual_network" "devops" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + dns_servers         = [
          + "8.8.8.8",
        ]
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "ireland"
      + name                = "demo-VNET"
      + resource_group_name = "dev-demo-RG"
      + subnet              = (known after apply)
      + tags                = {
          + "environment" = "dev"
        }
    }

  # random_id.randomId will be created
  + resource "random_id" "randomId" {
      + b64         = (known after apply)
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 8
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
      + keepers     = {
          + "resource_group" = "dev-demo-RG"
        }
    }

  # module.alert_1.azurerm_monitor_action_group.main will be created
  + resource "azurerm_monitor_action_group" "main" {
      + enabled             = true
      + id                  = (known after apply)
      + name                = "Test1-actiongroup"
      + resource_group_name = "dev-demo-RG"
      + short_name          = "Test1act"

      + webhook_receiver {
          + name        = "slack"
          + service_uri = "https://hooks.slack.com/services/{azerty}/XXXXXXXXXXXXXXx/{hook-key}"
        }
    }

  # module.alert_1.azurerm_monitor_metric_alert.this will be created
  + resource "azurerm_monitor_metric_alert" "this" {
      + auto_mitigate            = true
      + description              = "Action will be triggered when Transactions count is greater than 50."
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "Test1-metricalert"
      + resource_group_name      = "dev-demo-RG"
      + scopes                   = (known after apply)
      + severity                 = 3
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = (known after apply)
        }

      + criteria {
          + aggregation      = "Total"
          + metric_name      = "Transactions"
          + metric_namespace = "Microsoft.Storage/storageAccounts"
          + operator         = "GreaterThan"
          + threshold        = 50

          + dimension {
              + name     = "ApiName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.alert_1.azurerm_storage_account.to_monitor will be created
  + resource "azurerm_storage_account" "to_monitor" {
      + access_tier                      = (known after apply)
      + account_kind                     = "StorageV2"
      + account_replication_type         = "LRS"
      + account_tier                     = "Standard"
      + allow_blob_public_access         = true
      + enable_https_traffic_only        = true
      + id                               = (known after apply)
      + is_hns_enabled                   = false
      + location                         = "ireland"
      + name                             = "alertstorage"
      + primary_access_key               = (sensitive value)
      + primary_blob_connection_string   = (sensitive value)
      + primary_blob_endpoint            = (known after apply)
      + primary_blob_host                = (known after apply)
      + primary_connection_string        = (sensitive value)
      + primary_dfs_endpoint             = (known after apply)
      + primary_dfs_host                 = (known after apply)
      + primary_file_endpoint            = (known after apply)
      + primary_file_host                = (known after apply)
      + primary_location                 = (known after apply)
      + primary_queue_endpoint           = (known after apply)
      + primary_queue_host               = (known after apply)
      + primary_table_endpoint           = (known after apply)
      + primary_table_host               = (known after apply)
      + primary_web_endpoint             = (known after apply)
      + primary_web_host                 = (known after apply)
      + resource_group_name              = "dev-demo-RG"
      + secondary_access_key             = (sensitive value)
      + secondary_blob_connection_string = (sensitive value)
      + secondary_blob_endpoint          = (known after apply)
      + secondary_blob_host              = (known after apply)
      + secondary_connection_string      = (sensitive value)
      + secondary_dfs_endpoint           = (known after apply)
      + secondary_dfs_host               = (known after apply)
      + secondary_file_endpoint          = (known after apply)
      + secondary_file_host              = (known after apply)
      + secondary_location               = (known after apply)
      + secondary_queue_endpoint         = (known after apply)
      + secondary_queue_host             = (known after apply)
      + secondary_table_endpoint         = (known after apply)
      + secondary_table_host             = (known after apply)
      + secondary_web_endpoint           = (known after apply)
      + secondary_web_host               = (known after apply)

      + blob_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }
    }

  # module.alert_2.azurerm_monitor_action_group.main will be created
  + resource "azurerm_monitor_action_group" "main" {
      + enabled             = true
      + id                  = (known after apply)
      + name                = "Test2-actiongroup"
      + resource_group_name = "dev-demo-RG"
      + short_name          = "Test2act"

      + webhook_receiver {
          + name        = "slack"
          + service_uri = "https://hooks.slack.com/services/{azerty}/XXXXXXXXXXXXXXx/{hook-key}"
        }
    }

  # module.alert_2.azurerm_monitor_metric_alert.this will be created
  + resource "azurerm_monitor_metric_alert" "this" {
      + auto_mitigate            = true
      + description              = "Action will be triggered when Transactions count is greater than 50."
      + enabled                  = true
      + frequency                = "PT1M"
      + id                       = (known after apply)
      + name                     = "Test2-metricalert"
      + resource_group_name      = "dev-demo-RG"
      + scopes                   = (known after apply)
      + severity                 = 3
      + target_resource_location = (known after apply)
      + target_resource_type     = (known after apply)
      + window_size              = "PT5M"

      + action {
          + action_group_id = (known after apply)
        }

      + criteria {
          + aggregation      = "Total"
          + metric_name      = "Transactions"
          + metric_namespace = "Microsoft.Storage/storageAccounts"
          + operator         = "GreaterThan"
          + threshold        = 50

          + dimension {
              + name     = "ApiName"
              + operator = "Include"
              + values   = [
                  + "*",
                ]
            }
        }
    }

  # module.alert_2.azurerm_storage_account.to_monitor will be created
  + resource "azurerm_storage_account" "to_monitor" {
      + access_tier                      = (known after apply)
      + account_kind                     = "StorageV2"
      + account_replication_type         = "LRS"
      + account_tier                     = "Standard"
      + allow_blob_public_access         = true
      + enable_https_traffic_only        = true
      + id                               = (known after apply)
      + is_hns_enabled                   = false
      + location                         = "ireland"
      + name                             = "alertstorage"
      + primary_access_key               = (sensitive value)
      + primary_blob_connection_string   = (sensitive value)
      + primary_blob_endpoint            = (known after apply)
      + primary_blob_host                = (known after apply)
      + primary_connection_string        = (sensitive value)
      + primary_dfs_endpoint             = (known after apply)
      + primary_dfs_host                 = (known after apply)
      + primary_file_endpoint            = (known after apply)
      + primary_file_host                = (known after apply)
      + primary_location                 = (known after apply)
      + primary_queue_endpoint           = (known after apply)
      + primary_queue_host               = (known after apply)
      + primary_table_endpoint           = (known after apply)
      + primary_table_host               = (known after apply)
      + primary_web_endpoint             = (known after apply)
      + primary_web_host                 = (known after apply)
      + resource_group_name              = "dev-demo-RG"
      + secondary_access_key             = (sensitive value)
      + secondary_blob_connection_string = (sensitive value)
      + secondary_blob_endpoint          = (known after apply)
      + secondary_blob_host              = (known after apply)
      + secondary_connection_string      = (sensitive value)
      + secondary_dfs_endpoint           = (known after apply)
      + secondary_dfs_host               = (known after apply)
      + secondary_file_endpoint          = (known after apply)
      + secondary_file_host              = (known after apply)
      + secondary_location               = (known after apply)
      + secondary_queue_endpoint         = (known after apply)
      + secondary_queue_host             = (known after apply)
      + secondary_table_endpoint         = (known after apply)
      + secondary_table_host             = (known after apply)
      + secondary_web_endpoint           = (known after apply)
      + secondary_web_host               = (known after apply)

      + blob_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }
    }

  # module.app.azurerm_network_interface.devops will be created
  + resource "azurerm_network_interface" "devops" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "ireland"
      + mac_address                   = (known after apply)
      + name                          = "demo-app-NIC"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "dev-demo-RG"
      + tags                          = {
          + "environment" = "dev"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "demo-app-NICConfiguration"
          + primary                       = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "dynamic"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = (known after apply)
        }
    }

  # module.app.azurerm_virtual_machine.devops will be created
  + resource "azurerm_virtual_machine" "devops" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = true
      + delete_os_disk_on_termination    = true
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "ireland"
      + name                             = "demo-app-VM"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "dev-demo-RG"
      + tags                             = {
          + "environment" = "dev"
        }
      + vm_size                          = "Standard_D1_v2"

      + boot_diagnostics {
          + enabled     = true
          + storage_uri = (known after apply)
        }

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }

      + os_profile {
          + admin_username = "daeda"
          + computer_name  = "appVM"
          + custom_data    = (known after apply)
        }

      + os_profile_linux_config {
          + disable_password_authentication = true

          + ssh_keys {
              + key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCohXWgFUTuzH1Jmbo+TB+b85kR/7D/0Lvx/m38hNUGPfJRZCvdkAALOgfVnAWt66Q7V1VJ7q9VJhwiDgVjI08qE6FBdOk1mrvyXaqo00zHIRjpZGKcMHZgzDx6n/r89IUKSOr7/ATHNY98xpARB5RKgHyspQlmXzC+tJcRLDzLnTh2Zmu7GQSU+BLmIpTv3/9pzItbgFREw6xhxCg31E+FTGuDDPzW5SXCYiWS8u9XBbmx/asdnU/r0OuOvLeA5gX7YBU/PdCxO8uCoC6C4Fk2t3a6caG60NYuHYUDF5Ou83DHy+m74K2rPFYSbmMWdwiNhjIngUmsMwffBFQu0puX my-east1"
              + path     = "/home/daeda/.ssh/authorized_keys"
            }
        }

      + storage_data_disk {
          + caching                   = (known after apply)
          + create_option             = "Empty"
          + disk_size_gb              = 50
          + lun                       = 0
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "demo-app-DataDisk"
          + write_accelerator_enabled = false
        }

      + storage_image_reference {
          + offer     = "RHEL"
          + publisher = "RedHat"
          + sku       = "7.4"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "demo-app-Disk"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # module.app-backup.azurerm_recovery_services_vault.devops will be created
  + resource "azurerm_recovery_services_vault" "devops" {
      + id                  = (known after apply)
      + location            = "ireland"
      + name                = "demo-vault"
      + resource_group_name = "dev-demo-RG"
      + sku                 = "Standard"
      + soft_delete_enabled = true
    }

  # module.bastion.data.azurerm_public_ip.devops will be read during apply
  # (config refers to values not yet known)
 <= data "azurerm_public_ip" "devops"  {
      + allocation_method       = (known after apply)
      + domain_name_label       = (known after apply)
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = (known after apply)
      + ip_address              = (known after apply)
      + ip_version              = (known after apply)
      + location                = (known after apply)
      + name                    = "demo-bastion-PublicIP"
      + resource_group_name     = "dev-demo-RG"
      + reverse_fqdn            = (known after apply)
      + sku                     = (known after apply)
      + zones                   = (known after apply)

      + timeouts {
          + read = (known after apply)
        }
    }

  # module.bastion.azurerm_network_interface.devops will be created
  + resource "azurerm_network_interface" "devops" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "ireland"
      + mac_address                   = (known after apply)
      + name                          = "demo-bastion-NIC"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "dev-demo-RG"
      + tags                          = {
          + "environment" = "dev"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "demo-bastion-NICConfiguration"
          + primary                       = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "dynamic"
          + private_ip_address_version    = "IPv4"
          + public_ip_address_id          = (known after apply)
          + subnet_id                     = (known after apply)
        }
    }

  # module.bastion.azurerm_public_ip.devops will be created
  + resource "azurerm_public_ip" "devops" {
      + allocation_method       = "Dynamic"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "ireland"
      + name                    = "demo-bastion-PublicIP"
      + resource_group_name     = "dev-demo-RG"
      + sku                     = "Basic"
      + tags                    = {
          + "environment" = "dev"
        }
    }

  # module.bastion.azurerm_virtual_machine.devops will be created
  + resource "azurerm_virtual_machine" "devops" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = true
      + delete_os_disk_on_termination    = true
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "ireland"
      + name                             = "demo-bastion-VM"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "dev-demo-RG"
      + tags                             = {
          + "environment" = "dev"
        }
      + vm_size                          = "Standard_D1_v2"

      + boot_diagnostics {
          + enabled     = true
          + storage_uri = (known after apply)
        }

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }

      + os_profile {
          + admin_username = "daeda"
          + computer_name  = "bastionVM"
          + custom_data    = (known after apply)
        }

      + os_profile_linux_config {
          + disable_password_authentication = true

          + ssh_keys {
              + key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCohXWgFUTuzH1Jmbo+TB+b85kR/7D/0Lvx/m38hNUGPfJRZCvdkAALOgfVnAWt66Q7V1VJ7q9VJhwiDgVjI08qE6FBdOk1mrvyXaqo00zHIRjpZGKcMHZgzDx6n/r89IUKSOr7/ATHNY98xpARB5RKgHyspQlmXzC+tJcRLDzLnTh2Zmu7GQSU+BLmIpTv3/9pzItbgFREw6xhxCg31E+FTGuDDPzW5SXCYiWS8u9XBbmx/asdnU/r0OuOvLeA5gX7YBU/PdCxO8uCoC6C4Fk2t3a6caG60NYuHYUDF5Ou83DHy+m74K2rPFYSbmMWdwiNhjIngUmsMwffBFQu0puX my-east1"
              + path     = "/home/daeda/.ssh/authorized_keys"
            }
        }

      + storage_data_disk {
          + caching                   = (known after apply)
          + create_option             = (known after apply)
          + disk_size_gb              = (known after apply)
          + lun                       = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = (known after apply)
          + name                      = (known after apply)
          + vhd_uri                   = (known after apply)
          + write_accelerator_enabled = (known after apply)
        }

      + storage_image_reference {
          + offer     = "RHEL"
          + publisher = "RedHat"
          + sku       = "7.4"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "demo-bastion-Disk"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # module.cdn.azurerm_cdn_endpoint.app will be created
  + resource "azurerm_cdn_endpoint" "app" {
      + content_types_to_compress     = (known after apply)
      + host_name                     = (known after apply)
      + id                            = (known after apply)
      + is_compression_enabled        = false
      + is_http_allowed               = true
      + is_https_allowed              = true
      + location                      = "ireland"
      + name                          = "appdev"
      + origin_path                   = (known after apply)
      + probe_path                    = (known after apply)
      + profile_name                  = "app-cdn-profile-dev"
      + querystring_caching_behaviour = "IgnoreQueryString"
      + resource_group_name           = "dev-demo-RG"

      + origin {
          + host_name  = "appstorage.blob.core.windows.net"
          + http_port  = 80
          + https_port = 443
          + name       = "consents-documents"
        }
    }

  # module.cdn.azurerm_cdn_profile.app_cdn_profile will be created
  + resource "azurerm_cdn_profile" "app_cdn_profile" {
      + id                  = (known after apply)
      + location            = "ireland"
      + name                = "app-cdn-profile-dev"
      + resource_group_name = "dev-demo-RG"
      + sku                 = "Standard_Akamai"
    }

  # module.cdn.azurerm_storage_account.appstorage will be created
  + resource "azurerm_storage_account" "appstorage" {
      + access_tier                      = (known after apply)
      + account_kind                     = "StorageV2"
      + account_replication_type         = "LRS"
      + account_tier                     = "Standard"
      + allow_blob_public_access         = true
      + enable_https_traffic_only        = true
      + id                               = (known after apply)
      + is_hns_enabled                   = false
      + location                         = "ireland"
      + name                             = "appstorage"
      + primary_access_key               = (sensitive value)
      + primary_blob_connection_string   = (sensitive value)
      + primary_blob_endpoint            = (known after apply)
      + primary_blob_host                = (known after apply)
      + primary_connection_string        = (sensitive value)
      + primary_dfs_endpoint             = (known after apply)
      + primary_dfs_host                 = (known after apply)
      + primary_file_endpoint            = (known after apply)
      + primary_file_host                = (known after apply)
      + primary_location                 = (known after apply)
      + primary_queue_endpoint           = (known after apply)
      + primary_queue_host               = (known after apply)
      + primary_table_endpoint           = (known after apply)
      + primary_table_host               = (known after apply)
      + primary_web_endpoint             = (known after apply)
      + primary_web_host                 = (known after apply)
      + resource_group_name              = "dev-demo-RG"
      + secondary_access_key             = (sensitive value)
      + secondary_blob_connection_string = (sensitive value)
      + secondary_blob_endpoint          = (known after apply)
      + secondary_blob_host              = (known after apply)
      + secondary_connection_string      = (sensitive value)
      + secondary_dfs_endpoint           = (known after apply)
      + secondary_dfs_host               = (known after apply)
      + secondary_file_endpoint          = (known after apply)
      + secondary_file_host              = (known after apply)
      + secondary_location               = (known after apply)
      + secondary_queue_endpoint         = (known after apply)
      + secondary_queue_host             = (known after apply)
      + secondary_table_endpoint         = (known after apply)
      + secondary_table_host             = (known after apply)
      + secondary_web_endpoint           = (known after apply)
      + secondary_web_host               = (known after apply)

      + blob_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }
    }

  # module.cdn.azurerm_storage_container.blob will be created
  + resource "azurerm_storage_container" "blob" {
      + container_access_type   = "blob"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "blob"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = "appstorage"
    }

  # module.db.azurerm_sql_server.devops will be created
  + resource "azurerm_sql_server" "devops" {
      + administrator_login          = "admindb"
      + administrator_login_password = (sensitive value)
      + connection_policy            = "Default"
      + fully_qualified_domain_name  = (known after apply)
      + id                           = (known after apply)
      + location                     = "ireland"
      + name                         = "demo-db-sql"
      + resource_group_name          = "dev-demo-RG"
      + version                      = "12.0"
    }

  # module.frontend.azurerm_app_service.app-service will be created
  + resource "azurerm_app_service" "app-service" {
      + app_service_plan_id            = (known after apply)
      + app_settings                   = (known after apply)
      + client_affinity_enabled        = false
      + client_cert_enabled            = false
      + default_site_hostname          = (known after apply)
      + enabled                        = true
      + https_only                     = false
      + id                             = (known after apply)
      + location                       = "ireland"
      + name                           = "dev-app-service"
      + outbound_ip_addresses          = (known after apply)
      + possible_outbound_ip_addresses = (known after apply)
      + resource_group_name            = "dev-demo-RG"
      + site_credential                = (known after apply)
      + source_control                 = (known after apply)
      + tags                           = {
          + "environment" = "dev"
        }

      + auth_settings {
          + additional_login_params        = (known after apply)
          + allowed_external_redirect_urls = (known after apply)
          + default_provider               = (known after apply)
          + enabled                        = (known after apply)
          + issuer                         = (known after apply)
          + runtime_version                = (known after apply)
          + token_refresh_extension_hours  = (known after apply)
          + token_store_enabled            = (known after apply)
          + unauthenticated_client_action  = (known after apply)

          + active_directory {
              + allowed_audiences = (known after apply)
              + client_id         = (known after apply)
              + client_secret     = (sensitive value)
            }

          + facebook {
              + app_id       = (known after apply)
              + app_secret   = (sensitive value)
              + oauth_scopes = (known after apply)
            }

          + google {
              + client_id     = (known after apply)
              + client_secret = (sensitive value)
              + oauth_scopes  = (known after apply)
            }

          + microsoft {
              + client_id     = (known after apply)
              + client_secret = (sensitive value)
              + oauth_scopes  = (known after apply)
            }

          + twitter {
              + consumer_key    = (known after apply)
              + consumer_secret = (sensitive value)
            }
        }

      + connection_string {
          + name  = (known after apply)
          + type  = (known after apply)
          + value = (sensitive value)
        }

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + logs {
          + application_logs {
              + azure_blob_storage {
                  + level             = (known after apply)
                  + retention_in_days = (known after apply)
                  + sas_url           = (sensitive value)
                }
            }

          + http_logs {
              + azure_blob_storage {
                  + retention_in_days = (known after apply)
                  + sas_url           = (sensitive value)
                }

              + file_system {
                  + retention_in_days = (known after apply)
                  + retention_in_mb   = (known after apply)
                }
            }
        }

      + site_config {
          + always_on                   = false
          + dotnet_framework_version    = "v4.0"
          + ftps_state                  = (known after apply)
          + http2_enabled               = false
          + ip_restriction              = (known after apply)
          + linux_fx_version            = "DOTNETCORE|3.1"
          + local_mysql_enabled         = (known after apply)
          + managed_pipeline_mode       = (known after apply)
          + min_tls_version             = (known after apply)
          + remote_debugging_enabled    = false
          + remote_debugging_version    = (known after apply)
          + scm_ip_restriction          = (known after apply)
          + scm_type                    = "None"
          + scm_use_main_ip_restriction = false
          + websockets_enabled          = (known after apply)
          + windows_fx_version          = (known after apply)

          + cors {
              + allowed_origins     = (known after apply)
              + support_credentials = (known after apply)
            }
        }

      + storage_account {
          + access_key   = (sensitive value)
          + account_name = (known after apply)
          + mount_path   = (known after apply)
          + name         = (known after apply)
          + share_name   = (known after apply)
          + type         = (known after apply)
        }
    }

  # module.frontend.azurerm_app_service_plan.service-plan will be created
  + resource "azurerm_app_service_plan" "service-plan" {
      + id                           = (known after apply)
      + kind                         = "Linux"
      + location                     = "ireland"
      + maximum_elastic_worker_count = (known after apply)
      + maximum_number_of_workers    = (known after apply)
      + name                         = "dev-service-plan"
      + reserved                     = true
      + resource_group_name          = "dev-demo-RG"
      + tags                         = {
          + "environment" = "dev"
        }

      + sku {
          + capacity = (known after apply)
          + size     = "S1"
          + tier     = "Standard"
        }
    }

  # module.frontend.azurerm_frontdoor.example will be created
  + resource "azurerm_frontdoor" "example" {
      + backend_pools_send_receive_timeout_seconds   = 60
      + cname                                        = (known after apply)
      + enforce_backend_pools_certificate_name_check = false
      + header_frontdoor_id                          = (known after apply)
      + id                                           = (known after apply)
      + load_balancer_enabled                        = true
      + location                                     = (known after apply)
      + name                                         = "dev-FrontDoor"
      + resource_group_name                          = "dev-demo-RG"

      + backend_pool {
          + health_probe_name   = "exampleHealthProbeSetting1"
          + id                  = (known after apply)
          + load_balancing_name = "exampleLoadBalancingSettings1"
          + name                = "exampleBackendBing"

          + backend {
              + address     = "www.bing.com"
              + enabled     = true
              + host_header = "www.bing.com"
              + http_port   = 80
              + https_port  = 443
              + priority    = 1
              + weight      = 50
            }
        }

      + backend_pool_health_probe {
          + enabled             = true
          + id                  = (known after apply)
          + interval_in_seconds = 120
          + name                = "exampleHealthProbeSetting1"
          + path                = "/"
          + probe_method        = "GET"
          + protocol            = "Http"
        }

      + backend_pool_load_balancing {
          + additional_latency_milliseconds = 0
          + id                              = (known after apply)
          + name                            = "exampleLoadBalancingSettings1"
          + sample_size                     = 4
          + successful_samples_required     = 2
        }

      + frontend_endpoint {
          + custom_https_provisioning_enabled = false
          + host_name                         = "example-FrontDoor.azurefd.net"
          + id                                = (known after apply)
          + name                              = "exampleFrontendEndpoint1"
          + session_affinity_enabled          = false
          + session_affinity_ttl_seconds      = 0
        }

      + routing_rule {
          + accepted_protocols = [
              + "Http",
              + "Https",
            ]
          + enabled            = true
          + frontend_endpoints = [
              + "exampleFrontendEndpoint1",
            ]
          + id                 = (known after apply)
          + name               = "devRoutingRule1"
          + patterns_to_match  = [
              + "/*",
            ]

          + forwarding_configuration {
              + backend_pool_name                     = "exampleBackendBing"
              + cache_enabled                         = false
              + cache_query_parameter_strip_directive = "StripAll"
              + cache_use_dynamic_compression         = false
              + forwarding_protocol                   = "MatchRequest"
            }
        }
    }

  # module.service_networking.azurerm_dns_a_record.example will be created
  + resource "azurerm_dns_a_record" "example" {
      + fqdn                = (known after apply)
      + id                  = (known after apply)
      + name                = "test"
      + records             = [
          + "10.0.180.17",
        ]
      + resource_group_name = "dev-demo-RG"
      + ttl                 = 300
      + zone_name           = "test"
    }

  # module.service_networking.azurerm_dns_zone.this_dns will be created
  + resource "azurerm_dns_zone" "this_dns" {
      + id                        = (known after apply)
      + max_number_of_record_sets = (known after apply)
      + name                      = "test"
      + name_servers              = (known after apply)
      + number_of_record_sets     = (known after apply)
      + resource_group_name       = "dev-demo-RG"
    }

  # module.service_networking.azurerm_express_route_circuit.this will be created
  + resource "azurerm_express_route_circuit" "this" {
      + allow_classic_operations            = false
      + bandwidth_in_mbps                   = 50
      + id                                  = (known after apply)
      + location                            = "ireland"
      + name                                = "devexpressRoute1"
      + peering_location                    = "Silicon Valley"
      + resource_group_name                 = "dev-demo-RG"
      + service_key                         = (sensitive value)
      + service_provider_name               = "Equinix"
      + service_provider_provisioning_state = (known after apply)
      + tags                                = {
          + "environment" = "Production"
        }

      + sku {
          + family = "MeteredData"
          + tier   = "Standard"
        }
    }

  # module.service_networking.azurerm_storage_account.this_storage will be created
  + resource "azurerm_storage_account" "this_storage" {
      + access_tier                      = (known after apply)
      + account_kind                     = "StorageV2"
      + account_replication_type         = "LRS"
      + account_tier                     = "Standard"
      + allow_blob_public_access         = true
      + enable_https_traffic_only        = true
      + id                               = (known after apply)
      + is_hns_enabled                   = false
      + location                         = "ireland"
      + name                             = "devstorageacc"
      + primary_access_key               = (sensitive value)
      + primary_blob_connection_string   = (sensitive value)
      + primary_blob_endpoint            = (known after apply)
      + primary_blob_host                = (known after apply)
      + primary_connection_string        = (sensitive value)
      + primary_dfs_endpoint             = (known after apply)
      + primary_dfs_host                 = (known after apply)
      + primary_file_endpoint            = (known after apply)
      + primary_file_host                = (known after apply)
      + primary_location                 = (known after apply)
      + primary_queue_endpoint           = (known after apply)
      + primary_queue_host               = (known after apply)
      + primary_table_endpoint           = (known after apply)
      + primary_table_host               = (known after apply)
      + primary_web_endpoint             = (known after apply)
      + primary_web_host                 = (known after apply)
      + resource_group_name              = "dev-demo-RG"
      + secondary_access_key             = (sensitive value)
      + secondary_blob_connection_string = (sensitive value)
      + secondary_blob_endpoint          = (known after apply)
      + secondary_blob_host              = (known after apply)
      + secondary_connection_string      = (sensitive value)
      + secondary_dfs_endpoint           = (known after apply)
      + secondary_dfs_host               = (known after apply)
      + secondary_file_endpoint          = (known after apply)
      + secondary_file_host              = (known after apply)
      + secondary_location               = (known after apply)
      + secondary_queue_endpoint         = (known after apply)
      + secondary_queue_host             = (known after apply)
      + secondary_table_endpoint         = (known after apply)
      + secondary_table_host             = (known after apply)
      + secondary_web_endpoint           = (known after apply)
      + secondary_web_host               = (known after apply)

      + blob_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }
        }

      + identity {
          + principal_id = (known after apply)
          + tenant_id    = (known after apply)
          + type         = (known after apply)
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }
    }

  # module.service_networking.azurerm_storage_queue.this_queue will be created
  + resource "azurerm_storage_queue" "this_queue" {
      + id                   = (known after apply)
      + name                 = "devqueue"
      + storage_account_name = "devstorageacc"
    }

  # module.whitelistsg.azurerm_network_security_group.devopswsg will be created
  + resource "azurerm_network_security_group" "devopswsg" {
      + id                  = (known after apply)
      + location            = "ireland"
      + name                = "demo-WHITELIST-SG"
      + resource_group_name = "dev-demo-RG"
      + security_rule       = (known after apply)
    }

  # module.whitelistsg.azurerm_network_security_rule.devopswsg-inbound will be created
  + resource "azurerm_network_security_rule" "devopswsg-inbound" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "*"
      + direction                   = "Outbound"
      + id                          = (known after apply)
      + name                        = "demo-WHITELIST-IP-INBOUND"
      + network_security_group_name = "demo-WHITELIST-SG"
      + priority                    = 100
      + protocol                    = "Tcp"
      + resource_group_name         = "dev-demo-RG"
      + source_address_prefixes     = [
          + "0.0.0.0",
        ]
      + source_port_range           = "*"
    }

  # module.whitelistsg.azurerm_network_security_rule.devopswsg-outbound will be created
  + resource "azurerm_network_security_rule" "devopswsg-outbound" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "*"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "demo-WHITELIST-IP-OUTBOUND"
      + network_security_group_name = "demo-WHITELIST-SG"
      + priority                    = 100
      + protocol                    = "Tcp"
      + resource_group_name         = "dev-demo-RG"
      + source_address_prefixes     = [
          + "0.0.0.0",
        ]
      + source_port_range           = "*"
    }

Plan: 38 to add, 0 to change, 0 to destroy.


------------------------------------------------------------------------
------------------------------------------------------------------------

```
</details>

## Observability
Four Golden Signals

It's very easy to create dashboards with dozens of meaningless machine and application metrics, time-series graphs, and dashboards full of widgets that will only serve to overwhelm you and hide the truth.

The Four Golden Signals is a framework that aims to increase signal and reduce noise, increasing the likelihood that you're paying attention to the performance indicators that have the largest impact on your systems.

They can be used for all systems: technological or human, automated or organizational.

```
Latency
Traffic
Errors
Saturation
```
<details>
<summary>Summary</summary>
  
Latency
* What: How long something takes to respond or complete
* Why: Direct impact on customer experience

Traffic
* What: Total volume of work being done (or attempted)
* Why: Generally has a relationship to business volume, which maps directly to business value.


Errors
* What: Self explanatory! Usually expressed as a ratio of (# Failed Requests)/(# Successful Requests), which yields a simple, clearly defined target to aim for.
* Why: A solid indication of customer experience and the value - or lack thereof - being derived from our services. It's also so simple to understand that it is accessible to anyone in the organization, making it a very powerful indicator.

Saturation
* What: Ok, this one is a little tricky but tl;dr: How close are we to our total available capacity?
* Why: Has a direct relationship to scaling and capacity planning. This is what ensures we can keep the machine running!
</details>

## Permissions

### Best Practices
* Enable multi-factor authentication (MFA) for privileged users
* Use Groups to Assign Permissions to Users through Active directory
* Least Privileged 
* Azure Active Directory Sync with federated Services

![alt text](/Images/them_permissions.png "Permissions")

(#disaster-recoverye)## Disaster Recovery Plan
* Due to the determination of the RTO y RPO we will desing a strategy based in:
** Bakend layer autoscaling
** Backup lifecycles of 24 hs por the Backend layer
** Database Backup


## Compliance
* GDPR (data layer stored in EU-WEST)

# Migration
![alt text](https://cdn-images-1.medium.com/max/1600/0*WW36nabYAh5wn2v3. "Migration").

Advantages of Replatforming
* Cost-efficient
This approach is cost effective and does not require a major development project.
* Start small and scale as needed
Replatforming lets you move some workloads to the cloud, experiment with the cloud environment, learn lessons and then move on to other workloads, without committing to a large migration effort.
* Cloud-native functionalit
Re-platforming allows applications to leverage cloud capabilities like auto-scaling, managed storage and data processing services, infrastructure as code (IaC), and more.

## App Migration Plan
We will create a DNS record, with a blue green Deployment Strategy automated to Azure Cloud.
When the App is smoke tested and ready we will switch the LB to the new DNS record.

## Database Migration Plan
Offline versus online migrations
When you migrate databases to Azure by using Azure Database Migration Service, you can perform an offline or an online migration. With an offline migration, application downtime begins when the migration starts. For an online migration, downtime is limited to the time required to cut over to the new environment when the migration completes. It's recommended to test an offline migration to determine whether the downtime is acceptable; if not, perform an online migration.

We will use an Online approach with the Azure Database Migrate (Oracle --> Azure Postgresql Online)
https://docs.microsoft.com/en-us/azure/dms/tutorial-oracle-azure-postgresql-online

## Budget

Calculation Report

Ref. https://azure.microsoft.com/en-us/pricing/tco/calculator/

# Next Steps

## Event-Driven Architecture as a Solution
As well as you can build your systems with event-driven structures, you can also use it as a solution to your already built highly coupled environments. Let’s discuss how we can apply the event-driven approach as a solution.

## Converting to Event Messaging

Above all, our plan was simple:
* Publish an event when a transaction item created
* Fetch the related data when event received
* Convert to a piece of report string
* Persist in the RDBMS (SQL)
* Query data when generating the report

