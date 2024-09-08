%dw 2.0
output application/json
fun statusCode (status)= status match {
    case "A" -> "Active"
	case "P" -> "Pending"
	case "I" -> "Incomplete In CICS"
	case "C" -> "Cancel"
	case "N" -> "New"
	else status -> status
	}
	
---
{
	"bookingReferenceNumber": vars.bookingRefNumber default "",
	"bookingNumber": payload.Booking_Number__c[0] default "",
	"status": (statusCode(payload.Status__c[0] default "")) default ""
}