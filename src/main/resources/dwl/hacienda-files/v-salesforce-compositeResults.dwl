%dw 2.0
output application/json 
var compositeSuccessResponse = vars.compositeResponse filter (($.httpStatusCode == 200) or ($.httpStatusCode == 201))  default [] map {referenceId :  $.referenceId}
---
{
		compositeErrorResponse: vars.compositeResponse filter (($.httpStatusCode != 200) and ($.httpStatusCode != 201)) default [] map  
		{
			message: $.body.message[0],
			statusCode : $.httpStatusCode,
			errorCode: $.body.errorCode[0],
			referenceId :  $.referenceId
		},
		finalResponse : (compositeSuccessResponse.referenceId default [])
		
}