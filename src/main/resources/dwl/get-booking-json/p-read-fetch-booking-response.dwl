%dw 2.0
output application/json indent=false
---
if (payload.getBookingDetailsOutput.isSuccess) (read(payload.getBookingDetailsOutput.message, "application/json")) else (payload.getBookingDetailsOutput.message)