%dw 2.0
import * from dw::core::Binaries
output application/json
var errorMsg = (vars.dataMsgCause.sfError default "") ++ (vars.dataMsgCause.dataError default "") ++ (vars.loopError.errorType default "")
var emailFileName = (vars.fileName splitBy ".")[0]
---
{
	"serviceName": p('serviceName'),
	"message": (errorMsg) ++ (vars.loopError.errorMessage default ""),
	"errorCode": "400",
	"errorCause": (errorMsg) ++ (vars.loopError.errorCause default ""),
	"fileName": emailFileName,
	"messageId": vars.correlationId default correlationId,
	"dateTime": now() >> "GMT",
	"emailTemplateConfigStoreKey": p('truck.emailTemplate.dataIssue'),
	"isAttachment": true,
	"fileAttach": [{
		"fileName": emailFileName ++ ".xml",
		"fileValue": toBase64(write(vars.writeInput, "application/xml")),
		"contentType": "text/html",
	},
				{
		"fileName": "ErrorDetails_" ++ emailFileName ++ ".txt",
		"fileValue": toBase64(vars.fileDataDetails),
		"contentType": "text/html",
	}]
}