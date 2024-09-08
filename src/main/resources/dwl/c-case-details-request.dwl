%dw 2.0
output application/json
---
{
("bookingNumber" : vars.metaData.bookingNumber) if(!isEmpty(vars.metaData.bookingNumber)),
"bolNumber" : vars.metaData.bolNumber default "a" 
}