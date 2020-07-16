# test-agilemonkeys
A short test for Agile Monkeys


```
## Current Architecture.
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

## Questions
```
User / Permissions Migration

Are the users using auth/authentication federated service? SSO auth?

User’s apply through filling out forms without the necessity of creating an account with the bank (it is open to anyone) so there should be no auth involved.
In the future we might incorporate federated auth that will allow us to fill out some information that we currently request to users. So any prep work for the future would be great.

Data Migration

*Are we planning to migrate Oracle “As is” with license
Yes. However, we are open to suggestions if we could cut cost but keeping the performance and reliability.

*Are there any restrictions on the application’s geographic storage location?
Due to the regulations of the country in which the bank is located (assume a EU country) the data layer must be physically stored in the EU and we need to know where exactly data is located at any point in time.

Is the data/application subject to robust regulatory protocols?
Yes, since we are dealing with sensitive data, we have to comply with EU regulations, such as GDPR and also comply with financial rules

Interface System Constraints

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

Budget

Do we have budget limitations?
As many other financial enterprises, we are heavily investing in technology and budget should not be an issue. However, it would be great to have some realistic figure on the expected cost per month once we move to the cloud.

Performance and Scalability

Do we have the need of a high available System?
Yes, since the enrollment for credit cards can happen at any time, we cannot afford missing a potential customer due to our technology stack

Will we gather metrics? Application side, service mesh?
We should gather metrics, on the application side we should be able at least to tell how many people entered the site, filled out the form, or left, etc.
On the server side we should be monitoring load and performance and be proactive.

Do we currently use any kind of Automation CICD tool? Code quality check?
CICD Jenkins/CircleCI, SonarQube, Dependabot, we also do testing (unit testing, integration testing, ui testing), linting, we also run some pen testing tools to avoid potential security breaches due to malicious code.
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

## Azure Architecture
![alt text](/images/them.png "AWS diagram")

## Jenkins Automation
![alt text](/images/them_terratest.png "AWS diagram")

## Terratest
```
------------------------------------------------------------------------



```

## Migration Plan
