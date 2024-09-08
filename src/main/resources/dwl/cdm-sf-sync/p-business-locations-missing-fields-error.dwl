%dw 2.0
output application/json 
---
{
  "DocId": correlationId,
  "message": ("Following field(s) is/are missing in Business Locations Object: " ++ (if (isEmpty(payload."CDM_Location_Id__c")) "CDM_Location_Id, " else "") ++ (if (isEmpty(payload."City__c")) "City, " else "") ++ (if (isEmpty(payload."Country__c")) "Country, " else"") ++ (if (isEmpty(payload."CVIF_Location_Number__c")) "CVIF_Location_Number, " else "") ++ (if (isEmpty(payload.Name)) "AddressLine1(Name), "else "") ++ (if (isEmpty(payload."CDM_Org_Id__c")) "CDM_Org_Id, " else"") ++ (if (isEmpty(payload."LocationCode__c")) "LocationCode, " else "") ++ ".") replace (", .") with ".",
  "Active__c": payload."Active__c" as String default "",
  "Name": payload.Name default "",
  "CDM_Org_Id__c": payload."CDM_Org_Id__c" default "",
  "CDM_Location_Id__c": payload."CDM_Location_Id__c" default "",
  "City__c": payload."City__c" default "",
  "Country__c": payload."Country__c" default "",
  "SFID": payload."Id" default "",
  "CVIF_Location_Number__c": payload."CVIF_Location_Number__c" default "",
  "Last_Synched_with_CDM__c": payload."Last_Synched_with_CDM__c" default "",
  "LocationCode__c": payload."LocationCode__c" default "",
  "ccRecipient": vars.varRecipientEmail.ccRecipient,
  "toRecipient": vars.varRecipientEmail.toRecipient,
  "serviceName" : p('serviceName'),
  "emailTemplateConfigStoreKey" : p('cdm.location.template') 
}