%dw 2.0
output application/json
---
{
    "body" : {
				"bookingNumber": vars.bookingConfNumber
			},
    "className" : "CC_GetBookingDetailsJSON",
    "methodName" : "getBookingDetails^/bookingdetailsJSON^HttpPost^String"
}