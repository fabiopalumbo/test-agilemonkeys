# Basic Two-Tier AWS Architecture

This provides a simple two-tier architecture on Azure Services. 

The premise is that you have stateless app servers running behind
an LB serving traffic.


Ww will create 1 bastion host for adminsitration and LB + VM instances with an ASG for escalation

![alt text](../images/xxx")

## Proposed Architecture
# Replataform
```
Unlike the lift and shift approach, in Re plataform approach, a portion of the application or the entire application is optimized before moving to the cloud. 

Replatform approach allows developers to reuse the resources they are accustomed to working with such as legacy programming languages, development frameworks, and existing caches in the application.

This will azure that minor changes won’t affect the application functioning.Organizations willing to automate certain tasks, as mentioned before moving databases to the Amazon Relational Database Service.Organizations looking to leverage more cloud benefits other than just moving the application to the cloud.If for moving an application to cloud the source environment is not supporting the cloud, then a slight modification is required.If the on-premise infrastructure is complex and hinders scalability and performance, replatform is a goodOrganizations willing to automate tasks which are essentials to operations, but are not the business priorities.
```

This architecture builds and includes the following components:

*Web app*. A typical modern application might include both a website and one or more RESTful web APIs. A web API might be consumed by browser clients through AJAX, by native client applications, or by server-side applications. For considerations on designing web APIs, see API design guidance.

*Front Door*. Front Door is a layer 7 load balancer. In this architecture, it routes HTTP requests to the web front end. Front Door also provides a web application firewall (WAF) that protects the application from common exploits and vulnerabilities.

*VM instance with ASG* 

*Queue*. In the architecture shown here, the application queues background tasks by putting a message onto an Azure Queue storage queue. The message triggers a the process app. Alternatively, you can use Service Bus queues. 

*Cache*. Store semi-static data in Azure Cache for Redis.

*CDN*. Use Azure Content Delivery Network (CDN) to cache publicly available content for lower latency and faster delivery of content.

*Data storage*. Use Azure SQL Database for relational data. 

*Azure DNS*. Azure DNS is a hosting service for DNS domains, providing name resolution using Microsoft Azure infrastructure. By hosting your domains in Azure, you can manage your DNS records using the same credentials, APIs, tools, and billing as your other Azure services.


## Apply

After you run `terraform apply` on this configuration, it will
automatically output the DNS address of the ELB. After your instance
registers, this should respond with the default nginx web page.

To run, configure your Azure provider as described in 

https://www.terraform.io/docs/providers/azurem/index.html

Run with a command like this:

```
terraform apply -var ''    
```


For example:

```
terraform apply -var ''    
```
