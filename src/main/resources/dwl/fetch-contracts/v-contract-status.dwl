%dw 2.0
output application/java
var inputData = read(payload, "application/json")
var varStatusDesc = upper(inputData.StatusDesc)
---
{
  statusDesc: varStatusDesc,
  ownerId: if (varStatusDesc == p('fetchContract.status')) inputData.Contracts[0].OwnerID else inputData.OwnerID,
  contractNum: 
    if ((varStatusDesc == p("fetchContract.status")))
      inputData.Contracts[0].ContractNum
    else
      inputData.ContractNum,
  amendmentNum: 
    if ((varStatusDesc == p("fetchContract.status")))
      inputData.Contracts[0].AmendmentNum
    else
      inputData.AmendmentNum
}