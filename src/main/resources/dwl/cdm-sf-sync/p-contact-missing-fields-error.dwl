%dw 2.0
output application/json
---
{
	"DocId": correlationId,
	"message": "Error while updating the Contact, mandatory field(s)(Last Name and either of Email/Phone/MobilePhone) is/are missing in Contact Object: " 
              ++ ((if (isEmpty(payload.Email)) "Email, " else "")
              ++ (if (isEmpty(payload.WorkPhone)) "WorkPhone, " else "")
			  ++ (if (isEmpty(payload.LastName)) "LastName, " else "")
              ++ (if (isEmpty(payload.MobilePhone)) "MobilePhone, " else "") ++ ".") replace (", .") with ".",
	"FirstName": vars.varContactPayload.FirstName default "",
	"LastName": vars.varContactPayload.LastName default "",
	"Email": vars.varContactPayload.Email  default "",
	"MobilePhone": vars.varContactPayload.MobilePhone default "",
	"Phone": vars.varContactPayload.Phone default "",
	"Last_Synched_with_CDM__c": vars.varAccountPayload[0].Last_Synched_with_CDM__c default "", 
	"CDM_Contact_Id__c": vars.varContactPayload.CDM_Contact_Id__c  default "",
	"CDM_Location_Id__c" : vars.varContactPayload.CDM_Location_Id__c default "",
	"ccRecipient": vars.varRecipientEmail.ccRecipient,
	"toRecipient": vars.varRecipientEmail.toRecipient,
	"serviceName": p('serviceName'),
	"emailTemplateConfigStoreKey": p('cdm.contact.template')
	
}