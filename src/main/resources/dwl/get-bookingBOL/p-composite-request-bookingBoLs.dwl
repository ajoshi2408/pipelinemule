%dw 2.0
output application/json
---
{
	"compositeRequest": [{
		"method": p('riskonnect.composite.method'),
		"url": p('riskonnect.composite.url') ++ p('riskonnect.composite.bookingBoL')  ++ "'" ++ (vars.BookingNbr default '') ++ "'",
		"referenceId": "BookingBoLs__c"
	}]
}
