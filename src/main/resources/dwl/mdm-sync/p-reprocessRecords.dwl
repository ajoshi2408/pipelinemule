%dw 2.0
output application/json
---
payload filter (vars.reprocessRecords.*referenceId contains ($.referenceId))