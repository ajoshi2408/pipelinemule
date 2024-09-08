%dw 2.0
output application/json
var data = (vars.sfUpdatePayload filter $.Id == payload.id)[0]
var id = if (not isEmpty(payload.id)) (" SF Account Id: " ++ payload.id) else ""
var accountNumber = if (not isEmpty(data.Account_Number_for_Credit_Information__c)) (", Account Number:" ++ data.Account_Number_for_Credit_Information__c) else ""
var creditStatus = if (not isEmpty(data.Account_Status__c)) (", Credit Status: " ++ data.Account_Status__c) else ""
var creditLimit = if (not isEmpty(data.Credit_Limit__c)) (", Credit Limit: " ++ data.Credit_Limit__c) else ""
var salesTerm = if (not isEmpty(data.Credit_Terms__c)) (", Sales Term: " ++ data.Credit_Terms__c) else ""
var partyId = if (not isEmpty(data.Party_Id)) (", Party Id: " ++ data.Party_Id) else ""
var docId = if (not isEmpty(vars.docId)) (", DocId: " ++ vars.docId) else ""
var toRecipient = (p("credit.toRecipients") default "" splitBy (",")) map
{
	 email: $,
	"type": "TO"
}
var ccRecipient = (p("credit.ccRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
---

{
"message": "Failed to update credit Information for " ++ id ++ accountNumber ++ creditStatus ++ creditLimit ++ salesTerm ++ partyId ++ docId,
"errorCause" : payload.errorMessage,
"serviceName" : p('serviceName'),
"toRecipient": toRecipient,
"ccRecipient": ccRecipient,	
"emailTemplateConfigStoreKey" : p('credit.emailTemplateConfigStoreKey')
}