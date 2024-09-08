%dw 2.0
output application/json
var matchedBOL = (vars.sfResponse.Bill_Of_Lading_Number__c default [])
var sfNotMatchedBOL = (vars.billOfLadingList -- matchedBOL) default []
---
{ 
    sfNotMatchedResponse : sfNotMatchedBOL,
	bolNumber : sfNotMatchedBOL joinBy ","
}
