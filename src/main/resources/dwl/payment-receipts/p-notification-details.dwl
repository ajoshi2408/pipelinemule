%dw 2.0
var ccRecipient = (p("paymentReceipts.toRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
var toRecipient = (p("paymentReceipts.ccRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "TO"
}
output application/json
---
{
	entity: "Payment-Receipts",
	errorMessage: ("errorType :" ++ (error.errorType.asString default '') ++
    			"| detailedDescription :" ++ (error.detailedDescription default '') ++
    			"| failingComponent :" ++ (error.failingComponent default '')) default 'unable to process current request kindly check the logs',
	message: "Issue Occurred while processing Payment Receipts records",
	messageId: correlationId,
	toRecipient: toRecipient,
	ccRecipient: ccRecipient,
	dateTime: now() >> "GMT",
	emailTemplateConfigStoreKey: p("paymentReceipts.errorTemplate")
}