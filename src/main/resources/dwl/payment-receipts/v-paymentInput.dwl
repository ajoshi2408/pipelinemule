%dw 2.0
output application/json
---
payload filter
(!isEmpty($.invoiceNumber default "")) and
(!isEmpty($.billOfLading.number default "")) and
(sizeOf($.invoiceNumber default "") >= 12) and
(!(($.invoiceNumber default "") startsWith ("3G"))) and
(!(($.invoiceNumber default "") startsWith ("CUCR"))) and
(!(($.invoiceNumber default "") startsWith ("MB00"))) and
(!(($.billOfLading.number default "") startsWith ("3G"))) and
(!(($.billOfLading.number default "") startsWith ("CUCR"))) and
(!(($.billOfLading.number default "") startsWith ("MB00"))) and
(!isEmpty($.check.number default "")) and
($.batch.sourceName == (p ('paymentReceipts.batchSourceName') default ''))