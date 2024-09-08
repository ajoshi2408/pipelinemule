%dw 2.0
output application/json
var muleFailingComponent = error.failingComponent default ""
var statusCode = if ( not isEmpty(vars.errorDetails.statusCode) ) (vars.errorDetails.statusCode as String) else "500"
var errorDescription = error.detailedDescription default "No Information Available"
var message = vars.errorDetails.message default error.description
---
{
	"serviceName" : "CUSRES",
	"errorMessage": message ++ ":" ++ vars.documentId,
	"cause": errorDescription  ++ "<br> Mulesoft failing component : " ++ muleFailingComponent,
	"statusCode": statusCode,
	"emailTemplateConfigStoreKey" : p('cusres.emailTemplateConfigStoreKey')

}