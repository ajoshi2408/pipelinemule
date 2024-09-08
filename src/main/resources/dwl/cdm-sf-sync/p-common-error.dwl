%dw 2.0
output application/json
---
{
	"docId": correlationId,
	"message": "Error while processing request from CDM to SF : " ++ error.description default "Unable to update Accounts, Business Locations and contacts information in Salesforce" ++ " for DocId : " ++ correlationId,
	"errorMessage": error.detailedDescription default "Please check logs for more details",
	"serviceName" : p('serviceName'),
	"ccRecipient": vars.varRecipientEmail.ccRecipient,
	"toRecipient": vars.varRecipientEmail.toRecipient,	
	"emailTemplateConfigStoreKey" : p('template')
}