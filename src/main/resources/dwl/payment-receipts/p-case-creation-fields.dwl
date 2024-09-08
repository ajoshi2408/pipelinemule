%dw 2.0
output application/json
fun splitByUrl(requests) =	(requests splitBy ("/"))[7]
var sfPRdetails = flatten ((vars.getSFCompResponse.compositeResponse filter $.referenceId == "invoiceNumber").body.records default "" ) map {	($ - "attributes")} groupBy $.Invoice_Number__c

var PRDateTimeCase = vars.insertPayload filter $.toProcess == false  map ((item,index)-> {
bolNumber: item.B_L_Number__c default "",
invoiceNumber: item.Invoice_Number__c default "",
subject: "Payment receipt data not updated in C-Sight : Invoice Number : " ++  (item.Invoice_Number__c) default " " ,
errorMessage: "Payment receipt data not synced in C-Sight as payment date and time received from Oracle : " ++ item.Payment_date_Time__c default '' ++ " is older than current payment date and time in C-Sight : " ++ (sfPRdetails[(item.Invoice_Number__c default '')].Payment_date_Time__c[0] default "")  ,
paymentReceiptId:sfPRdetails[(item.Invoice_Number__c default "")].Id[0] default "",
missingBol : false
}) filter ($!={})



---
vars.sfSuccess map ((item,index)-> {

		bolNumber: item.bolNumber,
		invoiceNumber: item.invoiceNumber,
		subject: if ( isEmpty(item.bolNumber)  ) ("Bol number not available in payment receipt's data") else "Bol number not found in salesforce for payment receipts",
		errorMessage: if ( isEmpty(item.bolNumber) ) ("Bol number not available in payment receipt for invoice number: " ++  (item.invoiceNumber))
			   else "Bol number with number " ++ item.bolNumber ++ " for invoice number " ++  (item.invoiceNumber) ++ " is not available in salesforce",
		paymentReceiptId: item.id,
		missingBol : true

}) filter ($!={}) ++ PRDateTimeCase