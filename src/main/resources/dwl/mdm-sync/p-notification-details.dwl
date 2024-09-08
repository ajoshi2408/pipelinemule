%dw 2.0
var ccRecipient = (p("MDM.toRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
var toRecipient = (p("MDM.ccRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "TO"
}
output application/json
---
{
	entity: vars.entityName,
	errorMessage: ("errorType :" ++ (error.errorType.asString default '') ++
    			"| detailedDescription :" ++ (error.detailedDescription default '') ++
    			"| failingComponent :" ++ (error.failingComponent default '')) default 'unable to process current request kindly check the logs',
	message: "Issue Occurred while processing " ++ vars.entityName default " " ++ " records",
	messageId: correlationId,
	toRecipient: toRecipient,
	ccRecipient: ccRecipient,
	dateTime: now(),
	emailTemplateConfigStoreKey: p("MDM.errorTemplate"),
}