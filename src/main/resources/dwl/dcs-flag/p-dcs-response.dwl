%dw 2.0
output application/json
var description = 
				  if(vars.sfQueryResponse.DCS_Cleared__c?) 
				  	if(vars.sfUpdateResponse.successful == true)
				  		"Record updated successfully!" 
				  	else 
				  		vars.sfUpdateResponse.items.exception.message[0]
				  else if (isEmpty(vars.sfQueryResponse)) 
				  		"Bill of Lading and Equipment Number combination does not exist!"
				  else 
				  		("Record not updated as DCS_Cleared__c is already set to TRUE on : " 
				  		++ (vars.sfQueryResponse.DCS_Cleared_On__c[0] default '') 
  						++ " by " 
  						++ (vars.sfQueryResponse.LastModifiedBy.Name[0] default ''))
  				  
---
{ 
  "description": description , 
  "status": if(vars.sfUpdateResponse.successful == true)"Success" else "Failed",
  "equipmentNumber": vars.originalRequest.ContainerNo,
  "billOfLading":vars.originalRequest.BillOfLading
}