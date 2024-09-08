%dw 2.0
output application/json
var commaSepBOLNumber = vars.billOfLadingList map ("'$'") joinBy (",")
---
"SELECT Id, Bill_Of_Lading_Number__c FROM Bill_Of_Lading__c WHERE Bill_Of_Lading_Number__c IN " ++ '(' ++ commaSepBOLNumber ++ ')'	