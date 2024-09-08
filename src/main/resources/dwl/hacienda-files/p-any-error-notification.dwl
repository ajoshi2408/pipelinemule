%dw 2.0
output application/json
---
{
	"errorCause":  error.description default "No Information Available", 
	"errorMessage": "Unable to process the file for Hacienda in Salesforce-Inbound-System-Service,Moving file : " ++ (vars.haciendaFileName default "") ++ " to Error Folder",
	"errorCode" : "500" ,
	"emailTemplateConfigStoreKey" :p('hacienda.emailTemplateConfigStoreKey'),
	"serviceName" : p('serviceName'),
	"toRecipient" : vars.recipientsData.toRecipient,
	"ccRecipient" : vars.recipientsData.ccRecipient
}