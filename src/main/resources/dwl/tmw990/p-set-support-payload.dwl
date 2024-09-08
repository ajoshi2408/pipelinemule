%dw 2.0
output application/json
var causeMessage = (error.cause.message default"")
var message ="Error while processing TMW990 request from Kafka to VM"
---
{
  "errorMessage": message ++ (causeMessage),
  "statusCode" : "500",
  "requestorResource" : "Salesforce-inbound-system-service-tmw990-event",
  "impact" : "2",
  "urgency" : "1",
  "assignmentGroup" : p('support-system-service.assignmentGroup.tmw990'),
  "shortDescription":"TMW990 request from Kafka"
}