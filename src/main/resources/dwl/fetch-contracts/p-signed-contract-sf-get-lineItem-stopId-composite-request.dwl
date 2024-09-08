%dw 2.0
output application/json  
---
{
  compositeRequest: [
    ({
      method: "GET",
      url: "/services/data/" ++ p("salesforce.serviceVersion") ++ "/query?q=select id,name from Contract_Line_Item__c where Contract__c = '" ++ vars.sfContractId ++ "'",
      referenceId: "lineItemIds"
    }),
    ({
      method: "GET",
      url: "/services/data/" ++ p("salesforce.serviceVersion") ++ "/query?q=select id,Stop_Record_ID__c ,Contract_id__c,Stop_Line_Id__c from Stop__c where Contract_Id__c  ='" ++ vars.sfContractId ++ "'",
      referenceId: "stopIds"
    })
  ]
}