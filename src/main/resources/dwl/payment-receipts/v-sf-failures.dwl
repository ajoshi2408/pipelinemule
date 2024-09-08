%dw 2.0
var currentIterationSFFailureIndices = (payload.items map {
	(index: ($$)) if ($.successful == false),
	(message: $.payload.errors) if ($.successful == false),
} filter ($ != {
}))
output application/json
---
flatten (vars.sfFailures ++ ((currentIterationSFFailureIndices) map ((item, index) -> 
    vars.currentRecords filter $$ == item.index map 
    {
	errorMessage: item.message,
	invoiceNumber: $."Invoice_Number__c"
})default []))