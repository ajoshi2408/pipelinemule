%dw 2.0
output application/json skipNullOn = "everywhere"
var url = p('truck.sfcomposite.url')
var sfRequestData = vars.fileInput.correctTruckData
fun epValid(value) = if ( value != "Y" ) false else true
fun toDate(inputDate) =   if (!isEmpty(inputDate)) inputDate as Date {"format": "MM/dd/yyyy"} as Date {"format": "yyyy-MM-dd"} else null
---
sfRequestData map ((item, index) -> 
{
		"method": p('truck.sfcomposite.method'),
		"url": "$(url)$(item.SCAC)",
		"referenceId": "$(item.SCAC)_$(index)",
		"body": {
			"Auto_Liability_Expiry__c": toDate(item.AL_EXP),
			"General_Liability_Expiry__c": toDate(item.GL_EXP),
			"Trailer_Interchange_Expiry__c": toDate(item.TL_EXP),
			"Cargo_Limit_Expiry__c": toDate(item.CR_EXP),
			"Auto_Liability_Expiry_PN__c": toDate(item.AL_EXP_PN),
			"General_Liability_Expiry_PN__c": toDate(item.GL_EXP_PN),
			"Trailer_Interchange_Expiry_PN__c": toDate(item.TL_EXP_PN),
			"Cargo_Limit_Expiry_PN__c": toDate(item.CR_EXP_PN),
			"Is_Valid__c": epValid(item.EP_VALID),
			"Company_Description__c": item.CMPY
		}
	}
)