%dw 2.0
output application/json
var supportFileName = (vars.fileName splitBy ".")[0] ++ ".xml"
var descriptionMsg	= "Error Occurred at SalesForce inbound System Service: For File " ++ supportFileName default "" 
---
{
	"errorMessage": (error.errorType.asString default "") ++ ":-" ++ (error.description default "No Information Available"), 
	"statusCode" : "500",
	"serviceName" : p('serviceName'),
	"requestorResource" : "Truck Carrier's Interface",
	"impact" : "2",
	"urgency": "1",
	"assignmentGroup" : "Service Platform",
	"shortDescription": descriptionMsg,
	"emailTemplateConfigStoreKey": p('truck.emailTemplate.muleIssue')
}