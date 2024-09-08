%dw 2.0
output application/java
var partyIds = vars.sfResponse map $.CDM_Org_Id__c
var account = payload filter (partyIds contains $.PARTY_ID)
fun dateFormat(val)= if (!isEmpty(val)) ((val as Date) as String {format: "yyyy-MM-dd"}) else ""
fun dateTimeFormat(val)= if (!isEmpty(val)) ((val as DateTime) as String {format: "yyyy-MM-dd'T'HH:mm:ss"}) else ""
---
account map {
Id: (vars.sfResponse filter (item, index) -> item.CDM_Org_Id__c == $.PARTY_ID).Id[0] default "", 
Account_Number_for_Credit_Information__c: $.ACCOUNT_NUMBER default "",
Account_Termination_Date__c: dateFormat($.ACCOUNT_TERMINATION_DATE),						 							 
Status_For_Credit_Information__c:  if (not isEmpty($.STATUS))
									   ( 
										 if (($.STATUS) == "A") true
										 else false
										)
									  else "",
Account_Status__c: $.ACCOUNT_STATUS default "",
Credit_Limit__c: $.CREDIT_LIMIT default "",
Party_Usage_Code__c: p('credit.partyUsageCode'),
Account_Established_Date__c: dateFormat($.ACCOUNT_ESTABLISHED_DATE) default "",
Account_Status_Date__c: $.ACCOUNT_STATUS_DATE default "",
Credit_Terms__c: $.PAYMENT_TERMS default "",
Party_Id: $.PARTY_ID default "",
Last_Synched_with_Oracle__c: dateTimeFormat($.LAST_SYNCHED_WITH_ORACLE)
}