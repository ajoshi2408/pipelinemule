%dw 2.0
output application/java

var emptyFields = 
                 (if (isEmpty(payload.orderTenderResponse.orderNumber)) "orderNumber," else "")
                 ++(if (isEmpty (payload.orderTenderResponse.booking[0].bookingPrefix ))"bookingPrefix," else "")
                 ++(if (isEmpty(payload.orderTenderResponse.booking[0].bookingNumber))"bookingNumber," else "")
                 ++(if (isEmpty(payload.orderTenderResponse.booking[0].bookingSeq))"bookingSeq," else "")
var emptyFieldsSize = sizeOf(emptyFields)                 
---
{
    missingFields: if (emptyFieldsSize == 0) null else "Missing required field(s): " ++ emptyFields[0 to (emptyFieldsSize - 2)] ++ "."
}