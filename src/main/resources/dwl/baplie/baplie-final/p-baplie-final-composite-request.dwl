%dw 2.0
output application/json
var httpGet="GET"
var httpPost="POST"
var httpPatch="PATCH"
var sfurl= p("salesforce.serviceUrl")
var contentVersionURL=p("salesforce.contentVersionUrl")
---
{
 "allOrNone" : true,
    "compositeRequest": [    
    {
      "method": httpPost,
      "referenceId": "ContentVersionID",
      "body" :
       {
		PathOnClient: "Final_BAPLIE_toCBP_" ++ (vars.BAPKey[0 to 6] default "") ++ "_" ++ (now() as DateTime >> "America/New_York") as String  {format: "MM-dd-yyyy hh:mm a"} ++ " EST." ++ ((vars.originalPayload.BAPKey splitBy ".")[1] default "EDI"),
		"Title": "Final_BAPLIE_toCBP_" ++ (vars.BAPKey[0 to 6] default "") ++ "_" ++ (now() as DateTime >> "America/New_York") as String  {format: "MM-dd-yyyy hh:mm a"} ++ " EST",
		"VersionData": vars.originalPayload.FinalBapliePayload,
		"FirstPublishLocationId" : vars.vesselId,
		"ContentLocation" :"S",
		"Description": "Baplie from SI"
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
      "url": sfurl ++ "/query/?q=SELECT Id FROM ContentDocumentLink where LinkedEntityId='" ++ vars.vesselId ++ "' and contentDocumentId= '@{refContentDocumentId.records[0].ContentDocumentId}'"
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
      "method": httpPost,
      "referenceId": "refContentDistribution",
      "url": sfurl ++ "/sobjects/ContentDistribution",
      "body": {
		"ContentVersionId": "@{ContentVersionID.id}",
		"PreferencesAllowViewInBrowser" : true,
		"PreferencesNotifyOnVisit" : false,
		"Name" : "Final_BAPLIE_toCBP_" ++ (vars.BAPKey[0 to 6] default "") ++ "_" ++ (now() as DateTime >> "America/New_York") as String  {format: "MM-dd-yyyy hh:mm a"} ++ " EST"

      }
    },
    
    {
      "method": httpPatch,
      "referenceId": "refvesselEvent",
      "url": sfurl ++ "/sobjects/VesselEvents__c/" ++ vars.vesselId,
      "body": {
       
		"Status__c": "Sent To Customs",
		"Final_Baplie_Received__c": true
      }
    }
    
    ]
}
