%dw 2.0
output application/json
---
{
	"DocId": correlationId,
	"message": "Getting Location Site Number as Blank in Contact object",
	"FirstName": payload.FirstName default "",
	"LastName": payload.LastName default "",
	"Email": payload.Email  default "",
	"MobilePhone": payload.MobilePhone default "",
	"Phone": payload.Phone default "",
	"Last_Synched_with_CDM__c": vars.varAccountPayload[0].Last_Synched_with_CDM__c default "", 
	"CDM_Location_Id": payload.CDM_Location_Id__c default "",
	"CDM_Contact_Id__c": payload.CDM_Contact_Id__c default "",
	"ccRecipient": vars.varRecipientEmail.ccRecipient,
	"toRecipient": vars.varRecipientEmail.toRecipient,
	"serviceName": p('serviceName'),
	"emailTemplateConfigStoreKey": p('cdm.contact.template') 
}