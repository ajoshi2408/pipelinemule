%dw 2.0
output application/json
var haciendaRefId = vars.sfInsertPayload default [] map 
{
    "haciendaUniqueKey" : $.referenceId,
    "bolNumber" : $.body.B_L_Number__c,
    "equipNumber" : $.body.Equipment_Number__c
}
var errorCause = vars.compositeResults.compositeErrorResponse default [] map ((item, index) -> (item.message ++ " for equipmentNumber : " ++ haciendaRefId[?($.haciendaUniqueKey == item.referenceId)].equipNumber[0] ++ " , BOL Number : " ++ haciendaRefId[?($.haciendaUniqueKey == item.referenceId)].bolNumber[0])) joinBy " , " 
var errorMessage = vars.compositeResults.compositeErrorResponse.errorCode default [] distinctBy $ joinBy ","
---
{
	"errorCause": if(not isEmpty(errorCause)) errorCause else if (not isEmpty(errorMessage)) errorMessage else "No Information Available",
	"errorMessage": "Error occurred while inserting into Salesforce for Hacienda file: " ++ (vars.haciendaFileName default "") ++ " due to " ++ errorMessage ++ " , Moving file to Error Folder",
	"errorCode" : vars.compositeResults.compositeErrorResponse.statusCode distinctBy $ joinBy "," ,
	"emailTemplateConfigStoreKey" : p('hacienda.emailTemplateConfigStoreKey'),
	"serviceName" : p('serviceName'),
	"toRecipient": vars.recipientsData.toRecipient,
	"ccRecipient": vars.recipientsData.ccRecipient
		
}