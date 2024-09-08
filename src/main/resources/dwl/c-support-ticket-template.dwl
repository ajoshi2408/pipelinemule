%dw 2.0
output application/json
---
{
	"requestorName": p('serviceName'),
	"requestorResource": payload.requestorResource,
	"recipients":if (p('env') != 'prod') [  
      {  
         "email": p('support-system-service.email'),
         "type":"TO"
      },
      {  
         "email": p('support-system-service.cc'),
         "type":"CC"
      }
   ] else  [{
		"email": p('support-system-service.email'),
		"type": "TO"
	}],
	"errorCode": payload.statusCode,
	"impact": payload.impact,
	"urgency": payload.urgency,
	"assignmentGroup": payload.assignmentGroup,
	"shortDescription": payload.shortDescription,
	"comments": if(sizeOf(payload.errorMessage as String default "") <= 4000) payload.errorMessage 
	else payload.errorMessage[0 to 3999] as String  default "Unable to Process the Salesforce-Inbound-System-Service Request"
}