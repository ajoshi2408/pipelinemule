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
	"docId": vars.varErrorNotify.docId default correlationId,
	"message": if (not isEmpty(vars.varErrorNotify.message)) (vars.varErrorNotify.message) else if(not isEmpty(error)) error.description else "No information available",
	"errorMessage": vars.varErrorNotify.errorMessage default ("Error while invoking EDI300 booking process flow : " ++ (vars.storedPayload.bookingIdToBeChecked default "")),
	"serviceName" : p('serviceName'),
	"toRecipient": toRecipient,
	"ccRecipient": ccRecipient,	
	"emailTemplateConfigStoreKey" : p('booking.template')
}