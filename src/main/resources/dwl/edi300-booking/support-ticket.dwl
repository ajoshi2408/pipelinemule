%dw 2.0
output application/json
---
{
	"errorMessage" : if (not isEmpty(error.cause)) error.cause.message else vars.varErrorNotify.message , 
	"requestorResource" : "EDI300 Booking process",
	"statusCode" : "500",
	"impact" : "2",
	"urgency": "1",
	"assignmentGroup" : "Service Platform",
	"shortDescription": error.description
}