%dw 2.0
output application/json
var muleFailingComponent = error.failingComponent default ""
var errorDescription = error.detailedDescription default "No Information Available"
---
{
	"serviceName" : "BAPLIE Final",
	"errorMessage": "Error while processing baplieFinal request from Kafka to VM. Error: " ++ error.description,
	"cause": errorDescription  ++ "<br> Mulesoft failing component : " ++ muleFailingComponent,
	"statusCode": "500",
	"emailTemplateConfigStoreKey" : p('baplie.final.emailTemplateConfigStoreKey')
}