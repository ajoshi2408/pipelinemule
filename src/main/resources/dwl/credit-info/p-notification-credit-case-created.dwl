%dw 2.0
output application/json
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
	"message": "Case Created Successfully.", 
	"errorCause": vars.errorMessage,
	"serviceName" : p('serviceName'),
	"toRecipient": toRecipient,
	"ccRecipient": ccRecipient,		
	"emailTemplateConfigStoreKey" : p('credit.emailTemplateConfigStoreKey')
}