# test-agilemonkeys
A short test for Agile Monkeys


```
##Current Architecture.
Let’s imagine that a Bank has a monolithic architecture to handle the
enrollment for new credit cards.
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

##The Goal
As a company-wide initiative, we’ve been asked to
1. Migrate all our systems to Azure cloud
2. The company is shifting to event-driven architecture with
microservices

##The Test
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

## Requirement
* Azure with a Visual Studio Subscription
* Jenkins
* Terraform => v0.12
* For Terratest --> Go v0.13

### Constrains
* Blob Storage for Terraform State

## Improvement tbd
* 
* Puppet / Ansible recipie for EC2 Configuration

## AWS Architecture
![alt text](/images/them.png "AWS diagram")

## Jenkins Automation
![alt text](/images/them_terratest.png "AWS diagram")

## Terratest
```
------------------------------------------------------------------------



```
