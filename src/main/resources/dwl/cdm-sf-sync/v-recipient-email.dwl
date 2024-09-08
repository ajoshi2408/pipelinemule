%dw 2.0
output application/json
var toRecipient = (p('cdm.email.toRecipient') default "" splitBy (",")) map
{
	 email: $,
	"type": "TO"
}
var ccRecipient = (p('cdm.email.ccRecipient') default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
---
{
	"toRecipient": toRecipient,
	"ccRecipient": ccRecipient
}