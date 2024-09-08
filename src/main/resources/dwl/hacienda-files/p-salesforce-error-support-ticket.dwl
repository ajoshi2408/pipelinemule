%dw 2.0
output application/json
---
{
	"errorMessage" : "Unable to process the file " ++ (vars.haciendaFileName default "") ++ " for Hacienda in Salesforce-Inbound-System-Service due to : " ++  (error.description default "No Information Available"), 
	"requestorResource" : "Hacienda",
	"statusCode" : "500",
	"impact" : "2",
	"urgency": "1",
	"assignmentGroup" : p('assignmentGroup'),
	"shortDescription": "Unable to process Hacienda file in Salesforce-Inbound-System-Service"
}