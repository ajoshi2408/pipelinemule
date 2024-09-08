%dw 2.0
output application/json
var causeMessage = (error.cause.message default"")
var message ="Error while processing Cusres request from Kafka to VM"
---
{
  "errorMessage": message ++ (causeMessage),
  "statusCode" : "500",
  "requestorResource" : "Salesforce-inbound-system-service-Cusres-event",
  "impact" : "2",
  "urgency" : "1",
  "assignmentGroup" : p('support-system-service.assignmentGroup.cusres'),
  "shortDescription":"cusres request from Kafka"
}