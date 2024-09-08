%dw 2.0
output application/json  skipNullOn="everywhere"
---
{
  StatusDesc: payload.StatusDesc,
  Status: payload.Status,
  "Contract_Expiration_Date__c": 
    if (not (upper(payload.StatusDesc)) == p("fetchContract.expstatus"))
      payload.ContractValidTo
    else
      null
}