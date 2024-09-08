%dw 2.0
output application/json
var causeMessage = (error.cause.message default"")
var message ="Error while processing baplieFinal request from Kafka to VM"
---
{
  "errorMessage": message ++ (causeMessage),
  "statusCode" : "500",
  "requestorResource" : "Salesforce-inbound-system-service-baplieFinal-event",
  "impact" : "2",
  "urgency" : "1",
  "assignmentGroup" : p('support-system-service.assignmentGroup.baplieFinal'),
  "shortDescription":"baplieFinal request from Kafka"
}