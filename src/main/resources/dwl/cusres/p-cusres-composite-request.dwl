%dw 2.0
output application/java
fun formatDateTime (d) = (if(!isEmpty(d))(d as LocalDateTime{format: "yyMMddHHmm"} as String {format: "yyyy-MM-dd HH:mm"})  else "")
var httpGet="GET"
var httpPost="POST"
var httpPatch="PATCH"
var originalPayload=vars.originalPayload
var documentId=vars.documentId
var icDate= originalPayload.customsResponse.messageHeaders.interchange.interchangeDate
var icTime=originalPayload.customsResponse.messageHeaders.interchange.interchangeTime
var sfurl=p('salesforce.serviceUrl')
var cusresMessageDetailUrl=(sfurl ++ "/sobjects/Cusres_Message_Detail__c")
var transportVar= (originalPayload.customsResponse.messageDetails[0].transportCarriers default [] map  {
	"method": httpPost,
	"url": cusresMessageDetailUrl,
	"referenceId": "refTransportCarrierCreate" ++ $$,
	"body": {
		RecordTypeId: "@{refTransportCarrierQuery.records[0].Id}",
		Cusres_Response__c: "@{refHeader.id}",
		Transport_Cd_Qual__c: $.transportCdQual,
		Voyage_Number__c: $.voyageNumber,
		Transport_Mode__c: $.transportMode,
		SCAC__c: $.scac,
		Transport_Cd_List_Id__c: $.transportCdListId,
		Transport_Cd_List_Type__c: $.transportCdListType,
		Carrier_Name__c: $.carrierName,
		Lloyds_Cd__c: $.lloydsCd,
		Lloyds_Cd_Qual__c: $.lloydsCdQual,
		Code_List_Agency_Cd__c: $.codeListAgencyCd,
		Vessel_Name__c: $.vesselName,
		Vessel_Country__c: $.vesselCountry
	}
})

var locationVar= (originalPayload.customsResponse.messageDetails[0].locations default [] map (loc, locIndex) -> {
	"method": httpPost,
	"url": cusresMessageDetailUrl,
	"referenceId": "refLocationDetailCreate" ++ locIndex,
	"body": {
		RecordTypeId: "@{refLocationDetailQuery.records[0].Id}",
		Cusres_Response__c: "@{refHeader.id}",
		Loc_Ref_Qual__c: loc.locRefQual,
		Loc_DateTime__c: (loc.locDateTime default [] map (($.locDateTimeCdQual default "") ++ "|" ++ (formatDateTime($.locDateTime)) ++ "~" ++ ($.locDateTimeFormatCd default "") ++ ";")) reduce ($$ ++ $),
		Location_Ports__c: (loc.locationPorts default [] map (($.locationFunctionCd default "") ++ "|" ++ ($.locationPortCd default "") ++ ";")) reduce ($$ ++ $)
	}
})
var errorDetailVar= (originalPayload.customsResponse.messageDetails[0].errorDetails default [] map (errDetail, errDetailIndex) -> {
	"method": httpPost,
	"url": cusresMessageDetailUrl,
	"referenceId": "refErrorDetailCreate" ++ errDetailIndex,
	"body": {
		RecordTypeId: "@{refErrorDetailQuery.records[0].Id}",
		Cusres_Response__c: "@{refHeader.id}",
		Error_Level_Cd__c: errDetail.errorLevelCd,
		Error_References__c: (errDetail.errorReferences default [] map (($.errorRefCdQual default "") ++ "|" ++ ($.errorRefNumber default "") ++ ";")) reduce ($$ ++ $),
		Error_Codes__c: (errDetail.errorCodes default [] map (($.errorCode default "") ++ ";")) reduce ($$ ++ $),
		Error_Messages__c: (errDetail.errorMessages default [] map (($.errorMessageQual default "") ++ "|" ++ ($.errorMessage default "") ++ ";")) reduce ($$ ++ $)
	}
})
---
{
	"allOrNone": true,
	"compositeRequest": [
		{
			"method": httpPost,
			"url": sfurl ++ "/sobjects/Cusres_Response__c",
			"referenceId": "refHeader",
			"body": {
				"Sender_Id__c": originalPayload.customsResponse.messageHeaders.interchange.senderId,
				"Receiver_Id__c": originalPayload.customsResponse.messageHeaders.interchange.receiverId,
				"Interchange_DateTime__c": if (icDate == "") ""  else (if (icTime == "") (formatDateTime(icDate ++ "0000"))  else (formatDateTime(icDate ++ icTime))),
				"Interchange_Control_Number__c": originalPayload.customsResponse.messageHeaders.interchange.interchangeControlNumber,
				"Message_Reference_Number__c": originalPayload.customsResponse.messageDetails[0].messageReferenceNumber,
				"Document_Id__c": documentId,
				"Vessel_Event__c":vars.vesselEventId
			}
		},
		{
			"method": httpGet,
			"referenceId": "refTransportCarrierQuery",
			"url": sfurl ++ "/query/?q=SELECT Id FROM RecordType WHERE SobjectType = 'Cusres_Message_Detail__c' AND DeveloperName = 'Transport_Carrier'"
		}
		] ++ transportVar ++ [
		{
			"method": httpGet,
			"referenceId": "refLocationDetailQuery",
			"url": sfurl ++ "/query/?q=SELECT Id FROM RecordType WHERE SobjectType = 'Cusres_Message_Detail__c' AND DeveloperName = 'Location_Detail'"
		}
		] ++ locationVar ++ [
		{
			"method": httpGet,
			"referenceId": "refErrorDetailQuery",
			"url": sfurl ++ "/query/?q=SELECT Id FROM RecordType WHERE SobjectType = 'Cusres_Message_Detail__c' AND DeveloperName = 'Error_Detail'"
		}
		] ++ errorDetailVar ++ [
		{
			"method": httpPatch,
			"url": sfurl ++ "/sobjects/Cusres_Response__c/@{refHeader.id}",
			"referenceId": "refFlowCompletedUpdate",
			"body": {
				"Flow_Completed__c": true
			}
		}
	]
}