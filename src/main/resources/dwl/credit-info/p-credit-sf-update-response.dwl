%dw 2.0
output application/java
---
{
errorResponse:(
	vars.sfUpdateResponse map (sfUpdateResponseForEachAccount, index) ->
    if (sfUpdateResponseForEachAccount.success == false) 
	{  
	    "id": vars.sfUpdatePayload.Id[index],
		"errorMessage" : sfUpdateResponseForEachAccount.errors[0].message ++ ". ErrorCode - " ++ sfUpdateResponseForEachAccount.errors[0].statusCode
	}
	else "Success"
              ) - "Success"
}