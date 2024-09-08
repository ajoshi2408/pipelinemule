%dw 2.0
output application/json
---
{
	errorType: error.errorType.asString default "SF_COMPOSITE:ERROR",
	errorCause: error.detailedDescription default ":Error Occurred Inside For Each Loop",
	errorMessage: ":Error Occurred Inside For Each Loop"
}