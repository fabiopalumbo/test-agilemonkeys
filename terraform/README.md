# Basic Two-Tier AWS Architecture

This provides a simple two-tier architecture on Azure Services. 

The premise is that you have stateless app servers running behind
an LB serving traffic.


Ww will create 1 bastion host for adminsitration and LB + VM instances with an ASG for escalation

![alt text](../images/xxx")


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
