%dw 2.0
import divideBy from dw::core::Objects
var Bill_Of_Lading__c = ((payload.compositeResponse filter $.referenceId == 'Bill_Of_Lading__c' map (compResponse, indexOfCompResponse) -> {
  (compResponse.body.records default [] map {
    Booking_Number__c: $.Booking_Number__r.Booking_Number__c,
    entityType: "Bill_Of_Lading__c",
    ($ - 'Booking_Number__r' - 'attributes')
  })
}) reduce ($ ++ $$) default {} ) divideBy 11
var Party__c = ((payload.compositeResponse filter $.referenceId == 'Party__c' map (compResponse, indexOfCompResponse) -> {
  (compResponse.body.records default [] map {
    Booking_Number__c: $.Bill_Of_Lading_Number__r.Booking_Number__r.Booking_Number__c,
    Bill_Of_Lading_Number__c: $.Bill_Of_Lading_Number__r.Bill_Of_Lading_Number__c,
    entityType: "Party__c",
    ($ - 'Bill_Of_Lading_Number__r' - 'attributes')
  })
}) reduce ($ ++ $$) default {} ) divideBy 16
var Commodity__c = ((payload.compositeResponse filter $.referenceId == 'Commodity__c' map (compResponse, indexOfCompResponse) -> {
  (compResponse.body.records default [] map {
    Booking_Number__c: $.Bill_Item__r.Bill_Of_Lading_Number__r.Booking_Number__r.Booking_Number__c,
    Bill_Of_Lading_Number__c: $.Bill_Item__r.Bill_Of_Lading_Number__r.Bill_Of_Lading_Number__c,
    entityType: "Commodity__c",
    ($ - 'Bill_Item__r' - 'attributes')
  })
}) reduce ($ ++ $$) default {}) divideBy 11
output application/json  
---
(Bill_Of_Lading__c ++ Party__c ++ Commodity__c) groupBy ($.Bill_Of_Lading_Number__c)