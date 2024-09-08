%dw 2.0
output application/json
---
{
	(sfError: "Error occurred in SalesForce Upsert, ") if(!isEmpty(vars.sfErrorResponse)),
	(dataError: "Incorrect Data Present in Truck Carrier's File. ") if(!isEmpty(vars.fileInput.incorrectTruckData)) 	
}