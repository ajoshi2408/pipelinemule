%dw 2.0
output application/json
---
{
	"errorCause": "Failed to Create Case in Salesforce due to : " ++ (error.description default "No Information Available"),
	"message": vars.metaData.errorDescription default "Failed to Create Case in Salesforce",
	"serviceName" : p('serviceName'),
	"emailTemplateConfigStoreKey" : vars.metaData.emailTemplateConfigStoreKey,
	"errorMessage": vars.metaData.errorDescription default "Failed to Create Case in Salesforce",
}