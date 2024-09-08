%dw 2.0
import * from dw::core::Binaries
output application/json
var httpGet="GET"
var httpPost="POST"
var httpPatch="PATCH"
var sfurl= p("salesforce.serviceUrl")
var contentVersionURL=p("salesforce.contentVersionUrl")
fun toBase64String(value) = toBase64(value as String) default ""

---
{
 "allOrNone" : true,
    "compositeRequest": [
    	{
      "method": httpPost,
      "referenceId": "ContentVersionID",
      "body" :
       {
		PathOnClient: (vars.queryPayload.US_Customs_Manifest__r.Name default "") ++ "-" ++ (vars.queryPayload.Version_Number__c default "") ++ ".json",
		"Title": (vars.queryPayload.US_Customs_Manifest__r.Name default "") ++ "-" ++ (vars.queryPayload.Version_Number__c default ""),
		"VersionData": toBase64String(write(vars.originalPayload,"application/json")),
		"FirstPublishLocationId" : vars.queryPayload.Id,
		"ContentLocation" :"S",
		"Description": "US Custom Manifest EDI 355"
		},
		"url": contentVersionURL
	},
	{
      "method": httpGet,
      "referenceId": "refContentDocumentId",
      "url": sfurl ++ "/query/?q=Select ContentDocumentId from ContentVersion Where Id = '@{ContentVersionID.id}'"
    },
    
    {
      "method": httpGet,
      "referenceId": "refContentDocumentLinkId",
      "url": sfurl ++ "/query/?q=SELECT Id FROM ContentDocumentLink where LinkedEntityId='" ++ vars.queryPayload.Id ++ "' and contentDocumentId= '@{refContentDocumentId.records[0].ContentDocumentId}'"
    },
    
    {
      "method": httpPatch,
      "referenceId": "refContentDocumentLink",
      "url": sfurl ++ "/sobjects/ContentDocumentLink/@{refContentDocumentLinkId.records[0].Id}",
      "body": {
		"shareType" : "I",
		"Visibility": "AllUsers"
      }
    },
    {
      "method": httpPatch,
      "referenceId": "refUSManifestId",
      "url": sfurl ++ "/sobjects/US_Manifest_Version__c/" ++ vars.queryPayload.Id,
      "body": {
		"Response_Received_On__c" : (now() as DateTime >> "GMT") as String  {format: "yyyy-MM-dd'T'HH:mm:ssZ"}
      }
    }
    ]

}