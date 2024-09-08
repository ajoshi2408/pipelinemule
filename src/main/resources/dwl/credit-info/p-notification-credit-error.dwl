%dw 2.0
output application/json
var muleFailingComponent = error.failingComponent default ""
var exactError = (error.exception.cause.detailMessage default (error.exception.errorMessage.typedValue.message)) default "No Information Available"
var errorDescription = error.detailedDescription default exactError
var docId = vars.docId default ""
var shortDescription = vars.errorInfo.ShortDescription default "Unable to update credit information of Account in Salesforce"
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
	"message": shortDescription ++ " for DocId : " ++ docId,
	"errorCause": errorDescription  ++ " | Mulesoft failing component : " ++ muleFailingComponent,
	"serviceName" : p('serviceName'),
	"toRecipient": toRecipient,
	"ccRecipient": ccRecipient,	
	"emailTemplateConfigStoreKey" : p('credit.emailTemplateConfigStoreKey')
}