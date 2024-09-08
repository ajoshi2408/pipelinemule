%dw 2.0
output application/json
---
{
	"errorMessage" : "Unable to create case in Salesforce-Inbound-System-Service due to : " ++ (error.cause.detailMessage default error.detailedDescription),
	"requestorResource" : p('case.requestorResource'),
	"statusCode" : "500",
	"impact" : "2",
	"urgency": "1",
	"assignmentGroup" : p('assignmentGroup'),
	"shortDescription": "Unable to create case due to connectivity issue in Salesforce-Inbound-System-Service with Subject :  " ++ (vars.metaData.Subject default ""),
	"emailTemplateConfigStoreKey" : vars.metaData.emailTemplateConfigStoreKey
}