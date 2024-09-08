%dw 2.0
output application/json
---
{
	"allOrNone": false,
	"collateSubrequests": false,
	"compositeRequest": payload default []
}