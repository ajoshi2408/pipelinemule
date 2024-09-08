%dw 2.0
output application/java
var partyId = if (not isEmpty(payload.PARTY_ID)) (" Party Id: " ++ payload.PARTY_ID) else ""
var creditlimit = if (not isEmpty(payload.CREDIT_LIMIT)) (", Credit Limit: " ++ payload.CREDIT_LIMIT) else ""
var custno = if (not isEmpty(payload.ACCOUNT_NUMBER)) (", Account Number:" ++ payload.ACCOUNT_NUMBER) else ""
var creditstatus = if (not isEmpty(payload.ACCOUNT_STATUS)) (", Account Status: " ++ payload.ACCOUNT_STATUS) else ""
var salesterm = if (not isEmpty(payload.PAYMENT_TERMS)) (", Credit Terms: " ++ payload.PAYMENT_TERMS) else ""
var docId = if (not isEmpty(vars.docId)) (", Doc Id: " ++ vars.docId) else "" 
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
"subject":p('credit.case.subject'),
"errorMessage": p('credit.case.description') ++ partyId ++ custno ++  creditlimit ++ creditstatus ++ salesterm ++ docId,
"PartyId": payload.PARTY_ID,
"toRecipient": toRecipient,
"ccRecipient": ccRecipient,
"emailTemplateConfigStoreKey" : p('credit.emailTemplateConfigStoreKey'),
"errorDescription" : "Error Occurred in Credit Case Creation flow for Party Id " ++ (payload.PARTY_ID default "")
}