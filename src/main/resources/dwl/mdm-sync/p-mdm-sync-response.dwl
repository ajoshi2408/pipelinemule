%dw 2.0
output application/json
---
{
	message: (attributes.headers.entity default "") ++ " : Records accepted for processing for ID : " ++ (correlationId default "")
}