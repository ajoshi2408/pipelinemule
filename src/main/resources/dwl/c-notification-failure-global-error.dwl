%dw 2.0
output application/json
---
{ 
	"errorMessage": "Unable To Raise Notification Due To: " ++ if (error.exception !=null) error.description else "No error information available,Unable to Raise Notification in Salesforce-Inbound-System-Service.",
	"statusCode" : if (!isEmpty(error.errorMessage.attributes.statusCode)) error.errorMessage.attributes.statusCode as String else "500"	
}