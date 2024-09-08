%dw 2.0
output application/java
var errMessage="The transaction was rolled back since another operation in the same transaction failed."
---
{
	"errorCode":400,
	"errorType":payload.compositeResponse.body[?($.message[0] != errMessage)]..errorCode[0],
	"message": (payload.compositeResponse.body[?($.message[0] != errMessage)]..message[0]) default ""
}