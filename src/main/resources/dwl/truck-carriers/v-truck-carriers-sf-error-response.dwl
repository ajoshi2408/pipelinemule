%dw 2.0
output application/json
---
(vars.truckSFResponse default []) as Iterator filter (($.httpStatusCode != "200" as Number) and ($.httpStatusCode != "201" as Number)) map ((item, index) -> 
{
  SCAC: (item.referenceId splitBy "_")[0],
  scacOrderId: (item.referenceId splitBy "_")[1],
  statusCode: item.httpStatusCode,
  errorMessage: write(item.body) 
})