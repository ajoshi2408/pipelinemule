%dw 2.0
var currentIterationSFSuccessIndices = (payload.items map {
	 (index : ($$)) if ($.successful == true),
     (id : $.id ) if ($.successful == true),
} filter ($ != {
}))
output application/json
---
flatten (vars.sfSuccess ++ ((currentIterationSFSuccessIndices) map ((item, index) -> 
    vars.currentRecords filter (($$ == item.index) and (isEmpty($.Bill_Of_Lading__c))) map 
    {
	(item),
	invoiceNumber: $."Invoice_Number__c",
	bolNumber : $.B_L_Number__c
})default []))