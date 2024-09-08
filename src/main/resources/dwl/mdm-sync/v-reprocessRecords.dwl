%dw 2.0 
var errorMessage = "The transaction was rolled back since another operation in the same transaction failed."
var errorCode = "PROCESSING_HALTED"
output application/json
---
vars.reprocessRecords ++ (flatten(vars.sfResponse.graphs.graphResponse.compositeResponse) map {
    referenceId : $.referenceId,
    errorCode : $.body.errorCode[0],
    message : $.body.message[0]
} filter $.errorCode == errorCode and  $.message == errorMessage) default []