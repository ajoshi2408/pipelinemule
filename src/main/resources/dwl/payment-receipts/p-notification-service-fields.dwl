%dw 2.0
output application/json
---
{
	message: "Error Occurred in Payment Receipt Request : " ++ (write(vars.sfFailures  reduce ($$ ++ $),'application/json')) default '',
	errorCode: "401",
	statusCode: "401",
	serviceName: app.name ++ '-Payment-Receipt',
	messageId: correlationId,
	assignmentGroup: "Service Platform",
	errorMessage: "Issue occurred in Payment Receipt",
	emailTemplateConfigStoreKey: p('paymentReceipts.errorTemplate'),
	entity: "Payment-Receipt",
	dateTime: now() >> "GMT"
}