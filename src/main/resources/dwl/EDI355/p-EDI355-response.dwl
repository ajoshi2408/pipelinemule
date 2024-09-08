%dw 2.0
output application/json
---
{
	"errorMessage": "No manifestRefId is present in salesforce with Id-" ++ vars.manifestRefId
}