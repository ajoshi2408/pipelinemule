%dw 2.0
output application/json
---
{
	errorMessage: "Error occurred due to " ++ 
				("errorType :" ++ (error.errorType.asString default '') ++
    			"| detailedDescription :" ++ (error.detailedDescription default '')),
	statusCode: if ( not isEmpty(error.errorMessage.attributes.statusCode) ) error.errorMessage.attributes.statusCode as String else "500",
	requestorResource: 'DCS - Flag'  default " ",
	impact: "2",
	urgency: "1",
	assignmentGroup: p('assignmentGroup'),
	shortDescription: if(sizeOf(error.description) > 159)error.description[0 to 159] else error.description default ''
}