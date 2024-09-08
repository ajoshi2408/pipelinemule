%dw 2.0
output application/java
var caseInputDetails = payload
---
{
	bolNumber : caseInputDetails.bolNumber,
	bookingNumber: caseInputDetails.bookingNumber,
	contract : caseInputDetails.contract,
	errorDescription : caseInputDetails.errorDescription ,
	emailTemplateConfigStoreKey : caseInputDetails.emailTemplateConfigStoreKey ,
	Subject : caseInputDetails.subject,
	Description : caseInputDetails.errorMessage,
	origin : caseInputDetails.origin,
	ownerId : caseInputDetails.ownerId,
	recordTypeId : caseInputDetails.recordTypeId,
	pricingType : caseInputDetails.pricingType,
	issueType : caseInputDetails.issueType,
	resolutionCategory : payload.resolutionCategory,
	paymentReceiptId:caseInputDetails.paymentReceiptId,
	priority: caseInputDetails.priority
}