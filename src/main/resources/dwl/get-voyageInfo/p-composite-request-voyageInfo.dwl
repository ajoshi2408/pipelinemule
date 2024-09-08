%dw 2.0
output application/json
---
{
	"compositeRequest": [{
		"method": p('riskonnect.composite.method'),
		"url": p('riskonnect.composite.url') ++ p('riskonnect.composite.voyageQuery')  ++ "'" ++ (vars.BoLId default '') ++ "'",
		"referenceId": "Voyage__c"
	}]
}
