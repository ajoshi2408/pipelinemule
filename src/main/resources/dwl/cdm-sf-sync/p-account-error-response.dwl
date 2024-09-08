%dw 2.0
output application/json
---
{
	"DocId": correlationId,
	"message": "Error while updating the Account in Salesforce :" ++ (if(not isEmpty(payload.items[0].exception.message)) payload.items[0].exception.message else error.description default "") ++ "StatusCode received is :" ++ payload.items[0].statusCode default "",
	"Name": vars.varAccountPayload[0].Name default "",
	"CDM_Org_Id__c": vars.varAccountPayload[0].CDM_Org_Id__c default "",
	"Customer_Status__c": vars.varAccountPayload[0].Customer_Status__c default "",
	"CVIF__c": vars.varAccountPayload[0].CVIF__c default "",
	"SFID": vars.varAccountPayload[0].Id default "",
	"Last_Synched_with_CDM__c": vars.varAccountPayload[0].Last_Synched_with_CDM__c default "",
	"Type": vars.varAccountPayload[0]."Type" default "",
	"Legal_Name__c": vars.varAccountPayload[0].Legal_Name__c default "",
	"ccRecipient": vars.varRecipientEmail.ccRecipient,
	"toRecipient": vars.varRecipientEmail.toRecipient,
	"serviceName": p('serviceName'),
	"emailTemplateConfigStoreKey": p('cdm.account.template')
	
}