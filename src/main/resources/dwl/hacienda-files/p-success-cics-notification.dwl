%dw 2.0
output application/json
var toRecipient = (p("hacienda.cicsToRecipients") default "" splitBy (",")) map
{
	 email: $,
	"type": "TO"
}
var ccRecipient = (p("hacienda.ccRecipients") default "" splitBy (",")) map
{
	email: $,
	"type": "CC"
}
---
{
	"fileName":  vars.haciendaFileName, 
	"message": "Hacienda Response File processed successfully to C-Sight and placed in CICS FTP Location" ,
	"emailTemplateConfigStoreKey" : p('hacienda.cicsEmailTemplateConfigStoreKey'),
	"now" : now() >> "GMT",
	"toRecipient" : toRecipient,
	"ccRecipient" : ccRecipient
}