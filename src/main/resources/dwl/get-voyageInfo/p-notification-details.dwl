%dw 2.0
var ccRecipient = (p("riskonnect.toRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
var toRecipient = (p("riskonnect.ccRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "TO"
}
output application/json indent=false
---
{
	entity: "voyage-Info",
	errorMessage: ("errorType :" ++ (error.errorType.asString default '') ++
    			"| detailedDescription :" ++ (error.detailedDescription default '') ++
    			"| failingComponent :" ++ (error.failingComponent default '')) default 'unable to process current request kindly check the logs',
	message: "Issue Occurred while fetch details for BoL " ++ vars.BoLId default " " ,
	messageId: correlationId,
	toRecipient: toRecipient,
	ccRecipient: ccRecipient,
	dateTime: now() >> "GMT",
	emailTemplateConfigStoreKey: p("riskonnect.errorTemplate"),
}