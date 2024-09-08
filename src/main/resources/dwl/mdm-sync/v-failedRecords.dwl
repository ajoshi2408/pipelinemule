%dw 2.0 
var errorMessage = "The transaction was rolled back since another operation in the same transaction failed."
output application/json
---
vars.failedRecords ++ (flatten(vars.sfResponse.graphs.graphResponse.compositeResponse) map {
    referenceId : $.referenceId,
    errorCode : $.body.errorCode[0],
    message : $.body.message[0],
    httpStatusCode: $.httpStatusCode
} filter ($.errorCode != "PROCESSING_HALTED" or $.message != errorMessage )) default []