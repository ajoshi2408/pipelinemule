%dw 2.0
output application/json
var muleFailingComponent = error.failingComponent default ""
var exactError = (error.exception.cause.detailMessage default (error.exception.errorMessage.typedValue.message)) default "No Information Available"
var errorDescription = error.detailedDescription default exactError
var shortDescription = vars.errorMessage default "Unable to send Contracts to C-Sight"
var contractNum = vars.contractStatus.contractNum default ""
var amendmentNum = vars.contractStatus.amendmentNum default ""
---
{
	"errorMessage" :  (shortDescription) ++ "- Contract: " ++ contractNum ++ ", Amendment No:" ++ amendmentNum ++  " due to : " ++  (errorDescription) ++ " | Mulesoft failing component : " ++ muleFailingComponent, 
	"requestorResource" : "Fetch Contracts",
	"statusCode" : "500",
	"impact" : "2",
	"urgency": "1",
	"assignmentGroup" : "Service Platform",
	"shortDescription": shortDescription
}