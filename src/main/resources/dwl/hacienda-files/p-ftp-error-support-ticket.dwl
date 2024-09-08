%dw 2.0
output application/json
---
{
	"errorMessage" : "Unable to send file " ++ (vars.haciendaFileName default "") ++ " to " ++ (vars.errorAtFTPFolder default "") ++ " for Hacienda in Salesforce-Inbound-System-Service due to : " ++ (error.description default "No Information Available"),
	"requestorResource" : "Hacienda",
	"statusCode" : "500",
	"impact" : "2",
	"urgency": "1",
	"assignmentGroup" : p('assignmentGroup'),
	"shortDescription": "Unable to send file to " ++(vars.errorAtFTPFolder default "") ++ " for Hacienda"
}