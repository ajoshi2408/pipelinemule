%dw 2.0
output application/json
---
{
	"errorCause": "BOL Number : "  ++ (payload.bolNumber default "") ++ " not available in Salesforce",
	"errorMessage": "BOL Number Not Found in Salesforce for file " ++ (vars.haciendaFileName default ""),
	"serviceName" : p('serviceName'),
	"errorCode" : "404",
	"emailTemplateConfigStoreKey" : p('hacienda.emailTemplateConfigStoreKey'),
	"toRecipient": vars.recipientsData.toRecipient,
	"ccRecipient": vars.recipientsData.ccRecipient,
}