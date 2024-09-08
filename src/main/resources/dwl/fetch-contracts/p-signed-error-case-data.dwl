%dw 2.0
output application/java
var contractNum = vars.contractStatus.contractNum default ""
var amendmentNum = vars.contractStatus.amendmentNum default ""
---
{
	caseDetailsRequired : false,
	subject: "Contract's data for Contract: " ++ contractNum ++ " and Amendment: " ++ amendmentNum ++ " not updated in C-Sight - Customer CVIF: " ++ (vars.contractStatus.ownerId default ""),
	errorMessage: "Contract's data for Contract: " ++ contractNum ++ " and Amendment: " ++ amendmentNum ++ " not updated in C-Sight due to following error - " ++ vars.errorMessage,
	errorDescription: "Failed to update Contract in C-Sight." ++ " Contract: " ++ contractNum ++ " and Amendment: " ++ amendmentNum,
	contract :  vars.sfContractId default "",
	emailTemplateConfigStoreKey : p('fetchContract.emailTemplateConfigStoreKey'),
	origin : p('fetchContract.case.origin'),
	ownerId : p('fetchContract.case.ownerId'),
	recordTypeId : p('fetchContract.case.recordTypeId'),
	issueType : p('fetchContract.case.issueType'),
	priority: p('fetchContract.case.priority'),
	autoCaseIdentifier: p('fetchContract.case.autoCaseIdentifier')
}