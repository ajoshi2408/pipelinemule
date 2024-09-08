%dw 2.0
output application/java
---
{
	invoiceNumber : payload.invoiceNumber,
	bolNumber:payload.bolNumber
}