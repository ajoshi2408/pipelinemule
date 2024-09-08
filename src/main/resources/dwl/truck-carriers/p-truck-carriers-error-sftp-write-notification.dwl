%dw 2.0
import * from dw::core::Binaries
output application/json
var emailFileName = (vars.fileName splitBy ".")[0] ++ ".xml"
---
{
	"serviceName": p('serviceName'),
	"message": (error.detailedDescription default "Error Occurred on SFTP Write Connector"),
	"errorCode": "500",
	"errorCause": (error.errorType.asString default "") ++ ":- " ++ (error.description default ""),
	"fileName": emailFileName,
	"messageId": vars.correlationId default correlationId,
	"dateTime": now() >> "GMT",
	"emailTemplateConfigStoreKey": p('truck.emailTemplate.dataIssue'),
	"isAttachment": true,
	"fileAttach": [{
		"fileName": emailFileName,
		"fileValue": toBase64(write(vars.writeInput, "application/xml")),
		"contentType": "text/html",
	}]
}