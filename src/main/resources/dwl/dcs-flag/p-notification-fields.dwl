%dw 2.0
output application/json
---
{
	"serviceName": app.name ++  " : DCS-Flag Update",
	"errorMessage": "DCS flag not updated for  BoL " ++ (vars.originalRequest.BillOfLading default '') ++ " and equipment number " ++ (vars.originalRequest.ContainerNo default ''),
	"statusCode": "201",
	"messageId": correlationId,
	"url": "https://crowley2--commdev1.sandbox.lightning.force.com/" ++ (vars.caseCreationResponse.caseResponse.items.id[0] default ''),
	"emailTemplateConfigStoreKey": "DCS-SALESFORCE-CASE-TEMPLATE"
	
}