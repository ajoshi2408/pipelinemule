%dw 2.0
output application/java
fun addContractReference(value)= value map ((item, index) -> item ++ {"Contract__c": vars.sfContractId} )
---
[vars.contractAccountRequest ,vars.optionalServiceRequest,vars.lineItemRequest,vars.stopRequest]