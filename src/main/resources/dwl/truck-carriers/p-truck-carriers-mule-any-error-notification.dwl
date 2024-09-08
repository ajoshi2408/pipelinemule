%dw 2.0
output application/json
---
{
	"serviceName": p('serviceName'),
	"errorMessage": (error.detailedDescription default "") ++ ":- " ++ vars.message,
	"errorCode": "500",
	"errorCause": (error.errorType.asString default "") ++ ":- " ++ (error.description default ""),
	"message": "Original File will moved to the directory: /UIIA/RPA Ingested/Error",
	"fileName": vars.fileName,
	"messageId": vars.correlationId default correlationId,
	"dateTime": now() >> "GMT",
	"emailTemplateConfigStoreKey": p('truck.emailTemplate.muleIssue')
}