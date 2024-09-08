%dw 2.0
output application/java
var billOfLading = vars.sfResponse default []
var headerInfoData = vars.haciendaInput.HaciendaStatus.headerInfo
var url = p('hacienda.sfcomposite.url')
---
(flatten(billOfLading map ((bolItem, bolindex) -> vars.haciendaInput.HaciendaStatus.detailRecords filter bolItem.Bill_Of_Lading_Number__c == $.details.bolNumber))) default [] map ((detailrecorditem,detailrecordindex)->
using ( Hacienda_unique_key = (detailrecorditem.details.equipNumber default "") ++ (detailrecorditem.details.bolNumber default ""))
({
	method : p('hacienda.sfcomposite.method'),
	url : "$(url)$(Hacienda_unique_key)",
	referenceId : Hacienda_unique_key,
	body: {RecordTypeId: p('hacienda.recordId'),
    Voyage_Number__c : headerInfoData.voyageNumber,
    Lot_Number__c: headerInfoData.lotNumber,
    Unload_Date__c: headerInfoData.unloadDate as Date {format : "yyyyMMdd"} as Date {format: "yyyy-MM-dd"} default "" ,
    Vessel_Name__c: headerInfoData.vesselName,
	Message_Date_Time__c : headerInfoData.messageDateTime,
	B_L_Number__c: detailrecorditem.details.bolNumber,
	Equipment_Number__c: detailrecorditem.details.equipNumber,
	Release_validation_number__c: detailrecorditem.details.releaseNumber,
	Cargo_Statistics__c: detailrecorditem.details.taxIndicator,
	Consignee_Name__c: detailrecorditem.details.consigneeName,
	Bill_Of_Lading__c: billOfLading[?($.Bill_Of_Lading_Number__c) == (detailrecorditem.details.bolNumber)].Id[0]
}
}))