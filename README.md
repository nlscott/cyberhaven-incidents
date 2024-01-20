# Cyberhaven::Incidents


## Summary
A ruby gem to interact with the Cyberhaven incident API. Tested on Cyberhaven version 23.11.

---
## Installation

`sudo gem install cyberhaven-incidents`

---
## Usage

In order to run Cyberhaven Incidents, you are required to add these two variables to the top of your file, under the require `cyberhaven-incidents` line.

```ruby
#!/usr/bin/ruby

require "cyberhaven-incidents"

## UPDATE THESE VARIABLES ------------------------------------------------------
$refreshToken = "API-REFRESH-TOKEN"
$deployment = "company.cyberhaven.io"
```

---
## Example Commands

```ruby
## COMMANDS ########################################
Cyberhaven::Incidents::getBearerToken

## Incident Totals
Cyberhaven::Incidents::totalIncidents
Cyberhaven::Incidents::totalUnresolvedIncidents
Cyberhaven::Incidents::totalIgnoredIncidents
Cyberhaven::Incidents::totalInProgressIncidents
Cyberhaven::Incidents::totalResolvedIncidents

## Detailed Incident by ID
Cyberhaven::Incidents::Id::DetailedJson("incidentID")
Cyberhaven::Incidents::Id::DetailedYaml("incidentID")
Cyberhaven::Incidents::Id::DetailedReport("incidentID")

## Summarized Incident details by ID
Cyberhaven::Incidents::Id::SummaryJson("incidentID")
Cyberhaven::Incidents::Id::SummaryYaml("incidentID")
Cyberhaven::Incidents::Id::SummaryReport("incidentID")

## Incident details by user
puts Cyberhaven::Incidents::User::TotalIncidents("username")
puts Cyberhaven::Incidents::User::AllIncidents("username")
puts Cyberhaven::Incidents::User::AllIncidentsJson("username")
puts Cyberhaven::Incidents::User::AllIncidentsYaml("username")
Cyberhaven::Incidents::User::AllIncidentsCSV("username")

## Incident details by policy name
puts Cyberhaven::Incidents::Policy::TotalPolicyIncidents("policyName")
puts Cyberhaven::Incidents::Policy::AllIncidents("policyName")
puts Cyberhaven::Incidents::Policy::AllIncidentsJson("policyName")
puts Cyberhaven::Incidents::Policy::AllIncidentsYaml("policyName")
Cyberhaven::Incidents::Policy::AllIncidentsCSV("policyName")
```

---
## Reference
https://storage.googleapis.com/cyberhaven-docs/redoc-static.html#/paths/~1api~1rest~1v1~1incidents~1list/post*
