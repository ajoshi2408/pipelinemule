%dw 2.0
output application/java
---
"UM-" ++ payload.customsAcceptReject.messageDetails[0].manifestRefId default ""