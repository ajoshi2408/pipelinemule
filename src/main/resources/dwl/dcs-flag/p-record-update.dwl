%dw 2.0
fun dateTimeFormat (dt) =   (dt as LocalDateTime {
	format:"MM-dd-yyyy HH:mm:ss.SSSSSS"
} as String {
	format:"yyyy-MM-dd'T'HH:mm:ss.SSS"
}) as DateTime
var sfAPIFields = {
	ReleaseStatus : "DCS_Cleared_On__c"
}
import * from dw::core::Objects
output application/java
---
{
	objectType: "equipment__c",
	records: [{
		Id: vars.sfQueryResponse.Id[0],
		DCS_Cleared__c: if ( vars.originalRequest.ReleaseStatus == 1 ) true else if ( vars.originalRequest.ReleaseStatus == 0 ) false else null,
		DCS_Cleared_On__c: if ( vars.originalRequest.ReleaseStatus == 1 ) (dateTimeFormat(now() >> "GMT"))  else if ( vars.originalRequest.ReleaseStatus == 0 ) null else null,
		(fieldsToNull: valueSet(payload mapObject ((key: sfAPIFields[$$]) if(($ ~= 0))))  )
	}]
}

