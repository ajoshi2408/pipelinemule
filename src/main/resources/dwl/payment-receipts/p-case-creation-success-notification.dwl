%dw 2.0
output application/json
---
{
	message: "Case creation successful for BOL No:" ++ vars.caseCreateNotification.bolNumber ++ " Invoice No:" ++ vars.caseCreateNotification.invoiceNumber ++ " in Payment Receipt Request",
	errorCode: "201",
	statusCode: "201",
	serviceName: app.name ++ '-Payment-Receipt',
	messageId: correlationId,
	assignmentGroup: "Service Platform",
	errorMessage: if(payload.missingBol == true) "Case created due to missing BOL number in Payment-Receipt" else "Case created due to Payment DateTime received from Oracle is older then current Payment DateTime in Salesforce",
	emailTemplateConfigStoreKey:  p('paymentReceipts.errorTemplate'),
	entity: "Payment-Receipt",
	dateTime: now() >> "GMT"
}