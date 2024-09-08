%dw 2.0
output application/json
---
{
	"errorCause": "Received Empty Hacienda Response File: " ++ (vars.haciendaFileName default "No filename received") ++ " for Processing from FTP Server", 
	"errorMessage": "Unable to send Hacienda file to VM as Empty File Received in Salesforce-Inbound-System-Service, Moving File to Error Folder" ,
	"errorCode" : "400" ,
	"serviceName" : p('serviceName'),
	"emailTemplateConfigStoreKey" : p('hacienda.emailTemplateConfigStoreKey'),
	"toRecipient": vars.recipientsData.toRecipient,
	"ccRecipient": vars.recipientsData.ccRecipient
}