%dw 2.0
output text/plain
---
"select 
id,
BOL_Full_Equipment_Number__c,
Bill_Of_Lading_Number__c,
Bill_Of_Lading_Number__r.Bill_Of_Lading_Number__c,
DCS_Cleared__c,
DCS_Cleared_On__c,
LastModifiedBy.Name
from equipment__c where Bill_Of_Lading_Number__r.Bill_Of_Lading_Number__c = '" ++ (payload.BillOfLading default '' )++ "' and BOL_Full_Equipment_Number__c = '" ++ (payload.ContainerNo default '') ++ "'"