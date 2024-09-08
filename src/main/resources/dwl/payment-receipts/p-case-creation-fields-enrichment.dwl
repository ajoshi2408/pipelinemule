%dw 2.0
output application/json
---
payload ++ {origin: "Platform Automations",  caseDetailsRequired: true, emailTemplateConfigStoreKey:  p('paymentReceipts.errorTemplate')}