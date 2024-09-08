%dw 2.0
output application/java  
var lineItemIds = flatten((payload.compositeResponse)) filter $.referenceId == "lineItemIds" map {
  ($.body.records map {
    (($.Name)) : $.Id
  })
} reduce (item, accumulator) -> item ++ accumulator
---
(flatten(((payload.compositeResponse filter $.referenceId == "stopIds").body.records)) map {
  	Id: $.Id,
  	"Contract_Line_Item_ID__c": lineItemIds[$."Stop_Line_Id__c"]
} orderBy $.Id)
