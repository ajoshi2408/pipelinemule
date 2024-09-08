%dw 2.0
var CVIFComp= if ( isEmpty(payload) ) null  else (vars.getSFCompResponse.compositeResponse filter ($.referenceId =="CVIF__c") map (item,index) -> {
	records: item.body.records map (item1,index1) -> {
		Id: item1.Id,
		CVIF__c: item1.CVIF__c
	}
})
var bookingNoComp= if ( isEmpty(payload) ) null  else (vars.getSFCompResponse.compositeResponse filter ($.referenceId =="Booking_Number") map (item,index) -> {
	records: item.body.records map (item1,index1) -> {
		Id: item1.Id,
		Booking_Number__c: item1.Booking_Number__c
	}
})
var billOfLadingComp= if ( isEmpty(payload) ) null  else (vars.getSFCompResponse.compositeResponse filter ($.referenceId =="BL_Number") map (item,index) -> {
	records: item.body.records map (item1,index1) -> {
		Id: item1.Id,
		Bill_Of_Lading_Number__c: item1.Bill_Of_Lading_Number__c
	}
})

var sfPRdetails = flatten ((vars.getSFCompResponse.compositeResponse filter $.referenceId == "invoiceNumber").body.records default [] ) map {	($ - "attributes")} groupBy $.Invoice_Number__c

fun dateTimeFormat (dt) =   (dt as LocalDateTime {format:"MM-dd-yyyy HH:mm:ss.SSSSSS"} as String {format:"yyyy-MM-dd'T'HH:mm:ss.SSS"} ) 

var transformedData = (vars.paymentInput map (item,index) -> {
	
		(Customer_Account__c:CVIFComp.records[0][?$.CVIF__c ==item.party.cvif.number].Id[0]) if CVIFComp !=null,
		(Customer_Account_Number__c: item.party.cvif.number) if item.party.cvif.number !=null,
		(Booking__c:bookingNoComp.records[0][?$.Booking_Number__c ==item.booking.number].Id[0]) if bookingNoComp !=null,
		(Booking_Number__c: item.booking.number) if (item.booking.number !=null and item.booking.number !=""),	
		Bill_Of_Lading__c : if ((billOfLadingComp.records[0][?$.Bill_Of_Lading_Number__c == item.billOfLading.number].Id[0]) !=null)
									(billOfLadingComp.records[0][?$.Bill_Of_Lading_Number__c == item.billOfLading.number].Id[0])
							else if (item.invoiceNumber !=null and item.invoiceNumber !="")
									(billOfLadingComp.records[0][?$.Bill_Of_Lading_Number__c == (item.invoiceNumber splitBy ("_"))[0]].Id[0])
							else null,
		B_L_Number__c:  if (!isEmpty(item.billOfLading.number)) 
							(item.billOfLading.number) 
						else if (!isEmpty(item.invoiceNumber)) 
							(item.invoiceNumber splitBy ("_"))[0]
						else null,						
	    (Batch_Source_Name__c: item.batch.sourceName) if (!isEmpty(item.batch.sourceName)),
	    (Currency__c: item.transaction.currencyCode) if (!isEmpty(item.transaction.currencyCode)),
	    (Invoice_Currency__c: item.transaction.currencyCode) if (!isEmpty(item.transaction.currencyCode)),
	    (Receipt_Currency__c: item.receiptCurrency.code) if (!isEmpty(item.receiptCurrency.code)),
	    (Invoice_Number__c: item.invoiceNumber)if (!isEmpty(item.invoiceNumber)),
		(Invoice_Original_Amount__c: item.originalInvoice.amount) if (!isEmpty(item.originalInvoice.amount)),
	    (Party_Type__c: item.party.code) if (!isEmpty(item.party.code)),	    
	    (Payment_amount__c: item.payment.amount) if (!isEmpty(item.payment.amount)), 	    	    
	    (Payment_date_Time__c: item.recordHistory.creationDate as LocalDateTime {format:"MM-dd-yyyy HH:mm:ss.SSSSSS"} as DateTime {format:"yyyy-MM-dd'T'HH:mm:ss.SSS"} ) if (!isEmpty(item.recordHistory.creationDate)),	    	    
	    (Application_date__c: item.batch.date as Date {format:"MM-dd-yyyy"} as Date {format:"yyyy-MM-dd"}) if (!isEmpty(item.batch.date)),	    	    
	    (Payor_Name__c: item.payorName) if (!isEmpty(item.payorName)),
	    (Receipt_Number__c: item.check.number)  if (!isEmpty(item.check.number)), 
	    (Unpaid_Balance__c: item.openItem.amount)  if (!isEmpty(item.openItem.amount)), 
	    toProcess: dateTimeFormat(item.recordHistory.creationDate) >= ((sfPRdetails[item.invoiceNumber].Payment_date_Time__c[0] default ""))

})

output application/java
---
transformedData
