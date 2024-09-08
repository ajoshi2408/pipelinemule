%dw 2.0
output application/json
var muleFailingComponent = error.failingComponent default ""
var errorDescription = error.detailedDescription default "No Information Available"
---
{
	"serviceName" : "CUSRES",
	"errorMessage": "Error while processing cusres request from Kafka to VM. Error: " ++ error.description,
	"cause": errorDescription  ++ "<br> Mulesoft failing component : " ++ muleFailingComponent,
	"statusCode": "500",
	"emailTemplateConfigStoreKey" : p('cusres.emailTemplateConfigStoreKey')
}