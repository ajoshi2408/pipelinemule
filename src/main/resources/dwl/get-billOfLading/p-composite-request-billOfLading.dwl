%dw 2.0
output application/json
var billOfLading = "'" ++ (vars.BoLId default '') ++ "'"
var method = p('riskonnect.composite.method')
var url = p('riskonnect.composite.url')
---
{
	"compositeRequest": [{
		"method": method,
		"url": url ++ p('riskonnect.composite.billOfLading')  ++ billOfLading,
		"referenceId": "Bill_Of_Lading__c"
	} , 
{
		"method": method,
		"url": url ++ p('riskonnect.composite.commodity')  ++ billOfLading,
		"referenceId": "Commodity__c"
	} ,
{
		"method": method,
		"url": url ++ p('riskonnect.composite.party')  ++ billOfLading,
		"referenceId": "Party__c"
	}]
}
