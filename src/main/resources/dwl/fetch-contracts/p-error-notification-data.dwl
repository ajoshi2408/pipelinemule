%dw 2.0
output application/json
var muleFailingComponent = error.failingComponent default "NA"
var exactError = (error.exception.cause.detailMessage default (error.exception.errorMessage.typedValue.message)) default "No Information Available"
var errorDescription = error.detailedDescription default exactError
var errorMessage = vars.errorMessage default "Unable to send Contracts to C-Sight"
var toRecipient = (p("fetchContract.toRecipients") default "" splitBy (",")) map
{
	 email: $,
	"type": "TO"
}
var ccRecipient = (p("fetchContract.ccRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
---
{
	"errorCause": errorMessage,
	"errorMessage": errorDescription  ++ " | Mulesoft failing component : " ++ muleFailingComponent,
	"serviceName" : p('serviceName'),
	"contractNum" : vars.contractStatus.contractNum default "",
	"amendmentNum" : vars.contractStatus.amendmentNum default "",
	"toRecipient": toRecipient,
	"ccRecipient": ccRecipient,	
	"emailTemplateConfigStoreKey" : p('fetchContract.emailTemplateConfigStoreKey')
}