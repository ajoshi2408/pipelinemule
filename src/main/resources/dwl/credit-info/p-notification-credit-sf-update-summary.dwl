%dw 2.0
output application/json
var result = vars.sfUpdateSummary
var summaryCount = "Account Credit Info - Summary Count" ++ "<br>Total Records present in BI Report: " ++ vars.inputReqSize ++ "<br>Total Records Proccessed to Update in SF: " ++ result.totalRecords ++ "<br>Records Succesfully Updated in SF: " ++ result.successRecords ++ "<br>Records failed to Update in SF: " ++ result.failedRecords
var toRecipient = (p("credit.toRecipients") default "" splitBy (",")) map
{
	 email: $,
	"type": "TO"
}
var ccRecipient = (p("credit.ccRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
---
{
	"message": summaryCount,
	"messageId": vars.docId,
	"serviceName" : p('serviceName'),
	"toRecipient": toRecipient,
    "ccRecipient": ccRecipient,	
	"emailTemplateConfigStoreKey" : p('credit.summaryTemplateConfigStoreKey')
}