%dw 2.0
output application/java
var sfCaseDetailsResponse  = payload
---
{
   "recordTypeId":sfCaseDetailsResponse.recordTypeId default "",
   "recordLink":sfCaseDetailsResponse.recordLink default "",
   "parentCaseId":sfCaseDetailsResponse.parentCaseId default "",
   "ownerId":sfCaseDetailsResponse.ownerId default "",
   "message":sfCaseDetailsResponse.message default "",
   "isError":sfCaseDetailsResponse.isError default ""
}