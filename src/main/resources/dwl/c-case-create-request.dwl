%dw 2.0
output application/java
fun caseDetails(valueToBeAssgined,defaultValue,conditionToCheck) = if(conditionToCheck != null) valueToBeAssgined else defaultValue
---
[
{
	"Subject": vars.metaData.Subject,
	"Description": vars.metaData.Description,
	"Priority": vars.metaData.priority default p('case.salesforce.priority'),
	"Origin": caseDetails(vars.metaData.origin, p('case.salesforce.origin'),vars.metaData.contract),
	"OwnerId": caseDetails(vars.metaData.ownerId, payload.ownerId default "",vars.metaData.contract),
	"RecordTypeId": caseDetails(vars.metaData.recordTypeId, payload.recordTypeId default "",vars.metaData.contract),
	("Pricing_Type__c": vars.metaData.pricingType) if (vars.metaData.contract != null),
	("Issue_Type__c": vars.metaData.issueType) if (vars.metaData.contract != null),
	("Resolution_Category__c": vars.metaData.resolutionCategory) if (vars.metaData.contract != null),
	"ParentId": payload.parentCaseId default "",
	"Contract__c": vars.metaData.contract default "",
	"Bill_of_lading__c": vars.metaData.bolNumber default "",
	"Booking__c": vars.metaData.bookingNumber default "",
	"payment_receipt__c": 	vars.metaData.paymentReceiptId default "",
	"Auto_Case_Identifier__c": vars.metaData.autoCaseIdentifier default ""
}
]