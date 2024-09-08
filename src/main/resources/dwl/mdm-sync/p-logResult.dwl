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
import * from dw::core::Binaries
output application/json
---
{
	startTime: vars.StartTime,
	endTime: now(),
	failedRecords: vars.failedRecords,
	entity: vars.entityName,
	errorMessage: "The attached records could not be processed in Salesforce. Please check the file for reason of failure.",
	message: "There have been some processing errors for a number of records.",
	messageId: correlationId,
	dateTime: now(),
	isAttachment: true,
	toRecipient: toRecipient,
	ccRecipient: ccRecipient,
	emailTemplateConfigStoreKey: p("MDM.failedRecordsTemplate"),
	fileAttach: [{
		"fileName": vars.entityName default "" ++ "-Errors.json",
		"fileValue": toBase64((write(vars.failedRecords,"application/json")) as Binary),
		"contentType": "text/plain"
	}]
}