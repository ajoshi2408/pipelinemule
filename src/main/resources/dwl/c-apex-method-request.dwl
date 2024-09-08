%dw 2.0
output application/json
---
if (payload.methodName contains "HttpGet")
	{
		queryParams: payload.queryParams
	}
else payload.body	