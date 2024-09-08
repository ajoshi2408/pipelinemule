%dw 2.0
output application/java  
fun toDate(value) =
  if ((not value == null and not value == ""))
    value as Date {format: "dd/MM/yyyy"} as Date {format: "yyyy-MM-dd"}
  else
    null
var sfID = {
  Id: vars.sfContractId
}
---
{
	objectType : "Contract",
	records:[{
  Status: payload.StatusDesc,
  "StatusCode__c": payload.Status,
  ("Contract_Expiration_Date__c": toDate(payload."Contract_Expiration_Date__c")) if not payload."Contract_Expiration_Date__c" == null
} ++ (if (not sfID == null)
  sfID
else
  {})]}