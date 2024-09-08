%dw 2.0
output application/json
---
{
	"DocId": correlationId,
	"message": if(isEmpty(payload.CVIFNumber) and isEmpty(payload.OrgAttribute10)) "Getting CVIF number and CVIF Name blank from CDM" else if (isEmpty(payload.CVIFNumber)) "Getting CVIF number blank from CDM" else "Getting CVIF Name blank from CDM",
	"Name": payload.OrganizationName default "",
	"CDM_Org_Id__c": payload.PartyId default "",
	"Customer_Status__c": payload.CustomerStatus default "",
	"CVIF__c": payload.CVIFNumber default "",
	"SFID": vars.varAccountPayload[0].Id default "",
	"Last_Synched_with_CDM__c": payload.LastUpdateDate default "",
	"Type": "CUSTOMER",
	"Legal_Name__c": payload.OrgAttribute10 default "",
	"ccRecipient": vars.varRecipientEmail.ccRecipient,
	"toRecipient": vars.varRecipientEmail.toRecipient,
	"serviceName": p('serviceName'),
	"emailTemplateConfigStoreKey":  p('cdm.account.template')
	
}