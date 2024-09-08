%dw 2.0
output application/json
var muleFailingComponent = error.failingComponent default ""
var exactError = (error.exception.cause.detailMessage default (error.exception.errorMessage.typedValue.message)) default "No Information Available"
var errorDescription = error.detailedDescription default exactError
var shortDescription = vars.errorInfo.ShortDescription default "Unable to update credit information of Account in Salesforce"
var docId = vars.docId default ""
---
{
	"errorMessage" :  (shortDescription) ++ " for DocId : " ++ docId ++ " due to : " ++  (errorDescription) ++ " | Mulesoft failing component : " ++ muleFailingComponent, 
	"requestorResource" : "Credit Information",
	"statusCode" : "500",
	"impact" : "2",
	"urgency": "1",
	"assignmentGroup" : "Service Platform",
	"shortDescription": shortDescription
}