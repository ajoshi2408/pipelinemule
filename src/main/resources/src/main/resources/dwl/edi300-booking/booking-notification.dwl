%dw 2.0
output application/json
var toRecipient = (p('booking.toRecipients') default "" splitBy (",")) map
{
	 email: $,
	"type": "TO"
}
var ccRecipient = (p('booking.ccRecipients') default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
---
{
	"docId": vars.varErrorNotify.docId,
	"message": vars.varErrorNotify.message,
	"errorMessage": vars.varErrorNotify.errorMessage,
	"serviceName" : p('serviceName'),
	"toRecipient": toRecipient,
	"ccRecipient": ccRecipient,	
	"emailTemplateConfigStoreKey" : p('template')
}