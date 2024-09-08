%dw 2.0
output application/json
---
{
	"errorCause":  error.description default "No Information Available", 
	"errorMessage": "Unable to send file " ++ (vars.haciendaFileName default "") ++ " to " ++ (vars.errorAtFTPFolder default "") ++ " for Hacienda in Salesforce-Inbound-System-Service",
	"errorCode" : "500" ,
	"serviceName" : p('serviceName'),
	"emailTemplateConfigStoreKey" : p('hacienda.emailTemplateConfigStoreKey'),
	"toRecipient" : vars.recipientsData.toRecipient,
	"ccRecipient" : vars.recipientsData.ccRecipient
}