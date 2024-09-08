%dw 2.0
output application/json
---
{
	"cause":  error.description default "No Information Available", 
	"errorMessage": "Unable to Raise Support Ticket for the error " ++ (payload.shortDescription default "")  ++ " in Salesforce-Inbound-System-Service",
	"statusCode" : "500" ,
	"serviceName" : p('serviceName'),
	"emailTemplateConfigStoreKey" : vars.emailTemplateConfigStoreKey,
	"message": "Unable to Raise Support Ticket for the error " ++ (payload.shortDescription default "")  ++ " in Salesforce-Inbound-System-Service",
}
