%dw 2.0
var ccRecipient = (p("DCS.toRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
var toRecipient = (p("DCS.ccRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "TO"
}
output application/json
---
{
	entity: 'DCS - Flag',
	errorMessage: ("errorType :" ++ (error.errorType.asString default '') ++
    			"| detailedDescription :" ++ (error.detailedDescription default '') ++
    			"| failingComponent :" ++ (error.failingComponent default '')) default 'unable to process current request kindly check the logs',
	message: "Issue Occurred while processing ",
	messageId: correlationId,
	toRecipient: toRecipient,
	ccRecipient: ccRecipient,
	dateTime: now(),
	emailTemplateConfigStoreKey: p("DCS.errorTemplate")
}