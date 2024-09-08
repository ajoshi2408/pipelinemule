%dw 2.0
var sfqueries = (p("fetchContract.contract.delete.query")) splitBy ","
output application/java  
---
(sfqueries) default [] map ($ ++ (vars.sfContractId default "") ++ "'")