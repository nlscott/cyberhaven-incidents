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

## Detailed Incident details by ID
Cyberhaven::Incidents::Id::DetailedJson("#{incidentID}")
Cyberhaven::Incidents::Id::DetailedYaml("#{incidentID}")
Cyberhaven::Incidents::Id::DetailedReport("#{incidentID}")

## Summaried Incidents details by ID
Cyberhaven::Incidents::Id::SummaryJson("#{incidentID}")
Cyberhaven::Incidents::Id::SummaryYaml("#{incidentID}")
Cyberhaven::Incidents::Id::SummaryReport("#{incidentID}")

## Incident details by user
puts Cyberhaven::Incidents::User::DetailedRaw("username", "status", numberOfEvents)
puts Cyberhaven::Incidents::User::DetailedJson("username", "status", numberOfEvents)

#example
puts Cyberhaven::Incidents::User::DetailedJson("joedaily", "unresolved", 100)

• status options are: "ignored", "in_progress", "resolved", or "unresolved"
```

---
## Reference
https://storage.googleapis.com/cyberhaven-docs/redoc-static.html#/paths/~1api~1rest~1v1~1incidents~1list/post*
