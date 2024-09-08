%dw 2.0
output application/json
---
{
	"DocId": correlationId,
	"message": "Error while updating the Account : Following field(s) is/are missing in Account Object: " 
              ++ ((if (isEmpty(payload[0].CDM_Org_Id__c)) "CDM_Org_ID, " else "")
              ++ (if (isEmpty(payload[0].Type)) "Type, " else "")
              ++ (if (isEmpty(payload[0].Name)) "OrganizationName, " else "") ++ ".") replace (", .") with ".",
	"Name": payload[0].Name default "",
	"CDM_Org_Id__c": payload[0].CDM_Org_Id__c default "",
	"Customer_Status__c": payload[0].Customer_Status__c default "",
	"CVIF__c": payload[0].CVIF__c default "",
	"SFID": vars.varAccountPayload[0].Id default "",
	"Last_Synched_with_CDM__c": payload[0].Last_Synched_with_CDM__c default "",
	"Type": payload[0].Type default "",
	"Legal_Name__c": payload[0].Legal_Name__c default "",
	"ccRecipient": vars.varRecipientEmail.ccRecipient,
	"toRecipient": vars.varRecipientEmail.toRecipient,
	"serviceName": p('serviceName'),
	"emailTemplateConfigStoreKey": p('cdm.account.template')
	
}