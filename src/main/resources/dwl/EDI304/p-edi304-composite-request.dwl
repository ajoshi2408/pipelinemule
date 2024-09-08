%dw 2.0
output application/json indent = false
var httpPost="POST"
var httpPatch="PATCH"
var sfurl= p("salesforce.serviceUrl")

fun createRequest(entity) = vars.sfFields."$(entity)" map ((obj, index) ->   
    {
      "method": httpPost,
      "referenceId": entity ++ index,
      "body" :obj ++ {"Bill_Of_Lading_Number__c": "@{bolId.id}"},
	  "url": sfurl ++ "/sobjects/$(entity)"
	})

fun subRequest(entity,parentObj,parentEntity,parentIndex) = vars.sfFields."$(entity)" filter ($.Item_Sequence__c == parentObj.Sequence_Number__c) map ((obj, index) -> do {
       var billItemId= "@{" ++ parentEntity ++ parentIndex ++ ".id}"
       ---
    {
      "method": httpPost,
      "referenceId": entity ++ parentIndex ++ index,
      "body" : entity match {
          case "Charge_Line__c" -> obj ++ {"Bill_Of_Lading_Number__c": "@{bolId.id}",
                                           "Bill_Item__c": billItemId
                                           }
          else -> obj ++ {"Bill_Item__c": billItemId}
      },
	  "url": sfurl ++ "/sobjects/$(entity)"
	}
})

fun createItemSubRequest() =  flatten  (vars.sfFields.Bill_Item__c map ((item, index) ->
        (
            subRequest("Sub_Item__c",item,"Bill_Item__c",index)
        ++  subRequest("Commodity__c",item,"Bill_Item__c",index)
        ++  subRequest("Charge_Line__c",item,"Bill_Item__c",index)
        )))
	
---
[{
 	"graphId": now() as Number,
    "compositeRequest": [    
    {
      "method": httpPost,
      "referenceId": "bolId",
      "body" : vars.sfFields.Bill_Of_Lading__c,
	  "url": sfurl ++ "/sobjects/Bill_Of_Lading__c"
	}
	
	] ++ createRequest("Bill_Item__c")
	  ++ createRequest("Party__c")
      ++ createRequest("Voyage__c")
      ++ createRequest("Equipment__c")
      ++ createItemSubRequest()
      ++ [    
    {
      "method": httpPatch,
      "referenceId": "updatebolId",
      "url": sfurl ++ "/sobjects/Bill_Of_Lading__c/@{bolId.id}",
      "body": {
      	
		"MS_Flow_Completed__c" : true
		
      }}]     	
	}]