%dw 2.0
output application/java  
var sfLookupData = vars.sfLookup
fun ShippersOwn(value) = value match {   
        case x if ((x as String) == "Y") -> "YES"
        case x if ((x as String) == "N") -> "NO"    
        else -> null
}
fun trimValue(value) =
  if ((not value == "" and not value == null))
    value
  else
    null
fun trimDecimalValue(value) =
  if ((not value == null and not value == ""))
    value as String {format: ".##"} as Number
  else
    null
fun toDate(value) =
  if ((not value == null and not value == ""))
    value as Date {format: "yyyy-MM-dd'T'HH:mm:ss"} as Date {format: "yyyy-MM-dd"}
  else
    null
---
{
  "Contracts_Data": payload.Contracts default [] map (contractData, contractIndex) -> {
    Contract: {
      "ContractNumAmendmentNumIdentifier__c":contractData.ContractNum ++ contractData.AmendmentNum,
      "Softship_Contract_Number__c": contractData.ContractNum,
      Name: contractData.ContractNum,
      "Amendment_Number__c": contractData.AmendmentNum,
      "StatusCode__c": trimValue(contractData.Status),
      Status: trimValue(contractData.StatusDesc),
      AccountId: sfLookupData.idsByOwner."$(contractData.OwnerID)",
      "Region__c": trimValue(contractData.RegionCD),
      StartDate: toDate(contractData.ContractValidFrom),
      "Contract_Expiration_Date__c": toDate(contractData.ContractValidTo),
      "Source__c": "SoftShip",
      "RecordTypeId": sfLookupData.RecordTypeId,
      "RegionTxt__c" : contractData.RegionTxt
    },
    "Contract_Accounts__r": contractData.Affiliates default [] filter (not $.AffiliateID == contractData.OwnerID) map (affiliatesData, affiliatesIndex) -> {
      "Account__c": sfLookupData.idsByAffiliates[affiliatesData.AffiliateID default ""],
       Name: using (sfLookupAffiliates = sfLookupData.namesByaffiliates[affiliatesData.AffiliateID default "" ] )
         if (not sfLookupAffiliates == null)
		 ( (if (sizeOf (sfLookupAffiliates) > 67) (sfLookupAffiliates)[0 to 66] 
		   else (sfLookupAffiliates)) ++ "-" ++ contractData.ContractNum ++ "-" ++ contractData.AmendmentNum)
         else
          null
    },
    "OptionalServiceExceptions__r": contractData.OptionalServiceExceptions default [] map (opServiceExData, opServiceExIndex) -> {
      "TariffLevel__c": trimValue(opServiceExData.OPTTariffLevel),
      "ServiceName__c": trimValue(opServiceExData.OptionalServiceName),
      "ConditionCode__c": trimValue(opServiceExData.ConditionCode),
      "Exception__c": trimValue(opServiceExData.ContractException),
      "CalculatationBasisValue__c": trimDecimalValue(opServiceExData.OPTCalcBasisValue),
      "From__c": trimValue(opServiceExData.From),
      "PortOfLoading__c": sfLookupData.loadPorts[opServiceExData.POL default ""],
      "PortOfDischarge__c": sfLookupData.dischargePorts[opServiceExData.POD default ""],
      "To__c": trimValue(opServiceExData.To),
      "CargoType__c": trimValue(opServiceExData.CargoType),
      "CommodityCode__c": trimValue(opServiceExData.Commodity),
      "CommodityName__c": trimValue(opServiceExData.CommodityText),
      "ShippersOwn__c": ShippersOwn(opServiceExData.ShippersOwn) default "",
      "Default__c": trimValue(opServiceExData.GlobalDefault),
      "Fixed__c": (opServiceExData.IsFixed == p("fetchContract.yterm")),
      "Kind_of_Package__c": opServiceExData.KindOfPackage,
      "Origin_Sub_Location__c": opServiceExData.FromSublocation,
      "Destination_Sub_Location__c": opServiceExData.ToSublocation
    },
    "Contract_Line_Items__r": contractData.LineItems default [] map (lineItemData, lineItemIndex) -> {
      Name: trimValue(lineItemData.ContractLineId),
      "Amendment_Number__c": trimValue(lineItemData.AmendmentNum),
      "StatusCode__c": trimValue(lineItemData.Status),
      "StatusDescription__c": trimValue(lineItemData.StatusDesc),
      "OwnerID__c": trimValue(lineItemData.OwnerID),
      "OwnerName__c": trimValue(lineItemData.OwnerName),
      "Region__c": trimValue(lineItemData.RegionCD),
      "ValidFrom__c": toDate(lineItemData.ValidFrom),
      "ValidTo__c": toDate(lineItemData.ValidTo),
      "CustomerReference__c": trimValue(lineItemData.CustomerReference),
      "ReceiptTerm__c": trimValue(lineItemData.ReceiptTerm),
      "LocationFromRecord__c": 
        if ((lineItemData.ReceiptTerm) == p("fetchContract.pterm"))
          (sfLookupData.fromLocationRecTermP[lineItemData.LocationFrom default ""])
        else if ((lineItemData.ReceiptTerm) == p("fetchContract.rterm"))
          (sfLookupData.fromLocationRecTermR[lineItemData.LocationFrom default ""])
        else if ((lineItemData.ReceiptTerm) == p("fetchContract.cterm"))
          (sfLookupData.fromLocationRecTermC[lineItemData.LocationFrom default ""])
        else
          sfLookupData.fromLocationRecTermD[lineItemData.LocationFrom default ""],
      "LocationFrom__c": trimValue(lineItemData.LocationFrom),
      "LocationFromName__c": trimValue(lineItemData.LocationFromName),
      "LocationFromZip__c": trimValue(lineItemData.FromLocZip),
      "SubLocationFrom__c": trimValue(lineItemData.SubLocationFrom),
      "SubLocationFromName__c": trimValue(lineItemData.FromSubLocName),
      "POL__c": trimValue(lineItemData.POL),
      "POL_Sub_Location_Code__c": trimValue(lineItemData.POLSubLocationCode),
      "Customer_Pool_POL__c": trimValue(lineItemData.CustomerPoolPOL),
      "Customer_Pool_POL_SubLoc__c": trimValue(lineItemData.CustomerPoolPOLSubLoc),
      "ReceiptType__c": trimValue(lineItemData.ReceiptType),
      "From_Receipt_Condition__c": trimValue(lineItemData.FromReceiptCondition),
      "To_Delivery_Condition__c": trimValue(lineItemData.ToDeliveryCondition),
      "DrayageOptionFrom__c": trimValue(lineItemData.DragyageOptFrom),
      "DrayageOptionFromDescription__c": trimValue(lineItemData.DragyageOptFromDesc),
      "MaxStopOverFrom__c": trimValue(lineItemData.MaxStopOverFrom),
      "DeliveryTerm__c": trimValue(lineItemData.DeliveryTerm),
      "LocationToRecord__c": 
        if ((lineItemData.DeliveryTerm) == p("fetchContract.pterm"))
          (sfLookupData.toLocationRecTermP[lineItemData.LocationTo default ""])
        else if ((lineItemData.DeliveryTerm) == p("fetchContract.rterm"))
          (sfLookupData.toLocationRecTermR[lineItemData.LocationTo default ""])
        else if ((lineItemData.DeliveryTerm) == p("fetchContract.cterm"))
          (sfLookupData.toLocationRecTermC[lineItemData.LocationTo default ""])
        else
          sfLookupData.toLocationRecTermD[lineItemData.LocationTo default ""],
      "LocationTo__c": trimValue(lineItemData.LocationTo),
      "LocationToName__c": trimValue(lineItemData.LocationToName),
      "LocationToZip__c": trimValue(lineItemData.ToLocZip),
      "SubLocationTo__c": trimValue(lineItemData.SubLocationTo),
      "SubLocationToName__c": trimValue(lineItemData.ToSubLocName),
      "POD__c": trimValue(lineItemData.POD),
      "POD_SubLocation_Code__c": trimValue(lineItemData.PODSubLocationCode),
      "Customer_Pool_POD__c": trimValue(lineItemData.CustomerPoolPOD),
      "Customer_Pool_POD_SubLoc__c": trimValue(lineItemData.CustomerPoolPODSubLoc),
      "DeliveryType__c": trimValue(lineItemData.DeliveryType),
      "DrayageOptionTo__c": trimValue(lineItemData.DrayageOptTo),
      "DrayageOptionToDescription__c": trimValue(lineItemData.DrayageOptToDesc),
      "MaxStopOverTo__c": trimValue(lineItemData.MaxStopOverTo),
      "ItemType__c": trimValue(lineItemData.ItemType),
      "KindOfPackageCode__c": trimValue(lineItemData.KindofPacakage),
      "KindOfPackageName__c": trimValue(lineItemData.KindofPacakageName),
      "CommodityCode__c": trimValue(lineItemData.CommodityCode),
      "CommodityName__c": trimValue(lineItemData.CommodityName),
      "IsImdg__c": (lineItemData.IsImdg == p("fetchContract.yterm")),
      "Gross_Weight__c": trimValue(lineItemData.GrossWeightKg),
      "Gross_Weight_Lb__c": trimDecimalValue(lineItemData.GrossWeightLb),
      "Expected_Quantity__c": trimValue(lineItemData.ExpectedQuantity),
      "Transhipment__c": trimValue(lineItemData.Transhipment),
      "IsReefer__c": (lineItemData.IsReefer == p("fetchContract.yterm")),
      "IsEmpty__c": (lineItemData.IsEmpty == p("fetchContract.yterm")),
      "IsNOR__c": (lineItemData.IsNOR == p("fetchContract.yterm")),
      "IsShipperOwn__c": (lineItemData.IsShipperOwn == p("fetchContract.yterm")),
      "IsOOG__c": (lineItemData.IsOOG == p("fetchContract.yterm")),
      "Remark__c": trimValue(lineItemData.Remark)
    },
    "Stop__r": flatten((contractData.LineItems..StopOvers default [])) filter not $ == null map (StopOversData, StopOversIndex) -> {
      "Stop_Record_ID__c": StopOversData.StopRecordID,
      "Stop_Type__c": StopOversData.StopType,
      "Stop_Number__c": StopOversData.StopNumber,
      Name: StopOversData.StopLocationName,
      "Stop_Sub_Location_Name__c": StopOversData.StopSubLocationName,
      "Stop_Location__c": vars.locationStopIdsResponse[(StopOversData.StopLocation default '') ++ "-" ++ (StopOversData.StopLocation default '')].Id[0],
      "Stop_Sub_Location__c": vars.locationStopIdsResponse[(StopOversData.StopLocation default '') ++ "-" ++ (StopOversData.StopSubLocation default '')].Id[0],
      "Stop_Line_Id__c": StopOversData.ContractLineID
    }
  }
}