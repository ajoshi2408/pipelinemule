%dw 2.0
var CVIF__c=(vars.paymentInput.party.cvif.number filter (!isEmpty($)) map "'$'" joinBy ",")
var bookingNumber=(vars.paymentInput.booking.number filter (!isEmpty($)) map "'$'" joinBy ",")
var bill= vars.paymentInput map {
	billOfladingnum: if ( !isEmpty($.billOfLading.number) ) $.billOfLading.number  else ($.invoiceNumber splitBy "_")[0]
}
var commaSepBOLNumber= bill.billOfladingnum filter (!isEmpty($)) map ("'$'") joinBy (",")
var invoiceNumber= vars.paymentInput map {
	invoiceNumber: $.invoiceNumber
}.invoiceNumber map  ("'$'") joinBy (",")
fun wrapper (inputValue) = "(" ++ inputValue default '' ++ ")"
fun formatQuery (inputValue) = "/query?q=" ++ inputValue default ''
output application/json
---
if ( (isEmpty(CVIF__c)) and  (isEmpty(commaSepBOLNumber)) ) null  else  
{
	"compositeRequest": [({
		"method": p('paymentReceipts.compositeMethod'),
		"url": p('paymentReceipts.compositeURL') ++ p('paymentReceipts.compositeVersion') ++ formatQuery(p('paymentReceipts.compositeGETQueries.bol')) ++ wrapper(commaSepBOLNumber),
		"referenceId": "BL_Number"
	}) if ((!isEmpty(commaSepBOLNumber))), 
({
		"method": p('paymentReceipts.compositeMethod'),
		"url": p('paymentReceipts.compositeURL') ++ p('paymentReceipts.compositeVersion') ++ formatQuery(p('paymentReceipts.compositeGETQueries.booking')) ++ wrapper(bookingNumber),
		"referenceId": "Booking_Number"
	}) if ((!isEmpty(bookingNumber))),
({
		"method": p('paymentReceipts.compositeMethod'),
		"url": p('paymentReceipts.compositeURL') ++ p('paymentReceipts.compositeVersion') ++ formatQuery(p('paymentReceipts.compositeGETQueries.cvif')) ++ wrapper(CVIF__c),
		"referenceId": "CVIF__c"
	}) if ((!isEmpty(CVIF__c))),
({
		"method": p('paymentReceipts.compositeMethod'),
		"url": p('paymentReceipts.compositeURL') ++ p('paymentReceipts.compositeVersion') ++ formatQuery(p('paymentReceipts.compositeGETQueries.invoice')) ++ wrapper(invoiceNumber),
		"referenceId": "invoiceNumber"
	}) if ((!isEmpty(invoiceNumber)))]
}
