%dw 2.0
output application/json
---
{
	bolNumber: (vars.originalRequest.BillOfLading default ''),
	subject: "DCS flag not updated for  BoL " ++ (vars.originalRequest.BillOfLading default '') ++ " and equipment number " ++ (vars.originalRequest.ContainerNo default ''),
	errorMessage: "DCS Flag data not sent to C Sight as BoL number and equipment number combination is not available",
	origin: p('case.salesforce.origin'),
	ownerId: p('DCS.caseOwner'),
	recordTypeId: p('DCS.recordType'),
	priority: p('case.salesforce.priority'),
	autoCaseIdentifier: p('DCS.autoCaseIdentifier'),
	emailTemplateConfigStoreKey: p('DCS.errorTemplate'),
	caseDetailsRequired: false
}	  