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

# Current Architecture Diagram
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

# Proposed Azure Architecture
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

## Jenkins Automation
![alt text](/Images/them_terratest.png "Jenkins Automation")

## Terratest


<details>
<summary>Summary</summary>
  
```

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

## Permissions in this new account

### Best Practices
* Enable multi-factor authentication (MFA) for privileged users
* Use Groups to Assign Permissions to Users through Active directory
* Least Privileged 
* Azure Active Directory Sync with federated Services

![alt text](/Images/them_permissions.png "Permissions")

## Disaster Recovery Plan
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


## Budget Calculation

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

