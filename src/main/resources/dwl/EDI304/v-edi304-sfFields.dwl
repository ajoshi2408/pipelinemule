%dw 2.0
output application/json skipNullOn="everywhere"

fun referenceType(qualifier)= qualifier match {
    case "4H" -> "Commercial_Invoice_Number__c"
	case "BM" -> "Bill_Of_Lading_Reference__c"
	case "BN" -> "Booking_Reference_Number__c"
	case "CG" -> "Consignee_Reference_Number__c"
	case "CQ" -> "Customshouse_Broker_License_Number__c"
	case "CR" -> "Customer_Reference_Number__c"
	case "CT" -> "Contract_Number__c"
	case "ED" -> "Export_Declaration__c"
	case "EI" -> "Employer_s_Identification_Number__c"
	case "E8" -> "Service_Contract_Coverage_Number__c"
	case "EX" -> "Estimate_Number__c"
	case "FM" -> "FMC_Forwarders_Number__c"
	case "FN" -> "Forwarder_Reference_Number__c"
	case "IB" -> "Inbound_Number__c"
	case "PO" -> "Purchase_Order_Number__c"
	case "PR" -> "Price_Quote_Number__c"
	case "RF" -> "Export_Reference_Number__c"
	case "SI" -> "Shipper_Reference_Number__c"
	case "SR" -> "Sales_Responsibility__c"
	case "TJ" -> "Federal_Taxpayer_Identification_Number__c"
	case "TN" -> "Transaction_Reference_Number__c"
	case "VT" -> "Motor_Vehicle_ID_Number__c"
    else -> null
}

var header= payload.billoflading.boldetail
var locationVar=payload.billoflading.locations

var billOfLading= {

	Bill_Of_Lading_Number__c : payload.billoflading.blNumber,
	Bill_of_lading_Label__c : header.label,
	Sender_ID__c : header.senderID,
	Receiver_ID__c : header.receiverID,
	Origin_Voyage__c : header.originVoyage,
	Booking_Reference_Number__c : header.shipmentNbr,
	Name : payload.billoflading.blNumber,
	Bill_of_lading_Status__c : header.status,
	Mode_Type__c : header.modeType,
	Move_Type__c : header.moveType,
	Move_Type_Description__c : header.moveTypeDescription,
	Source__c : header.source,
	Initiate_Date__c : if(!isEmpty(header.initiateDate)) header.initiateDate else null,
	Issue_Date__c : if(!isEmpty(header.issueDate)) header.issueDate else null,
	Supplementary_Indicator__c : header.supplementaryInd,
	First_RR_Status__c : if(!isEmpty(header.firstRrStatus)) header.firstRrStatus else null,
	EDI_Source_Indicator__c : header.ediSourceindicator,
	Shipment_Id_Number__c : header.ediId,
	EDI_Received_Date__c : if(!isEmpty(header.idReceivedDate)) header.idReceivedDate else null,
	EDI_Received_Time__c : if(!isEmpty(header.idReceivedTime)) header.idReceivedTime else null,
	Prepaid_Collect__c : header.prepayCollectCd,
	Route__c : header.routeCd,
	Hazardous__c : header.hazInd,
	Hazardous_Emergency_Contact__c : header.hazEmerContact,
	Hazardous_Emergency_Phone_Number_1__c : header.hazEmerPhone,
	Hazardous_Emergency_Phone_Number_2__c : header.hazEmerPhone2,
	Military_Vessel_Voyage_Number__c : header.militaryVesVoyNbr,
	Military_Reference_Number__c : header.militaryRefNbr,
	Military_Move_Code__c : header.militaryMoveCd,
	Origin_DOACC_Code__c : header.origDodaccCd,
	Destination_DOACC_Code__c : header.destDodaccCd,
	Rate_Clerk_Agent__c : header.rateClerkInitials,
	SED_Exemption__c : header.sedExemptInd,
	X3RD_Reference_Number__c : header.xReferenceBlNumber,
	Memo_Reference_BOL_Number__c : header.memoXReferenceBlNumber,
	SCAC_Code__c : header.scacCd,
	Export_Reference_Number__c : header.exportReferenceNumber,
	EIN_Reference_Number__c : header.einReferenceNumber,
	Tax_Identification_Number__c : header.taxIdNumber,
	VGM_Weight_Lbs__c : header.vgmTotalWeightLbs,
	VGM_Weight_Kgs__c : header.vgmTotalWeightKg,
	BOL_Control_Location__c : header.bolCtlLoc,
	BOL_Metric_Indicator__c : header.bolMetricInd,
	ITN_Number__c : header.itnNumber,
	Tariff_Type__c : header.tarrifType,
	Inbond_Indicator__c : header.inBondInd,
	SED_Exemption_Code__c : header.sedExemptCode,
	SED_Exception_OPT4__c : header.sedExemptOpt4Dt,
	Alternative_Vessel__c : header.altVessel,
	Alternative_Load_Port__c : header.altLoadPort,
	Alternative_Discharge_Port__c : header.altDischargePort,
	Alternative_Place_Receipt__c : header.altPlaceReceipt,
	Alternative_Final_Destination__c : header.altFinalDest,
	Alternative_Loading_Terminal__c : header.altLoadTerminal,
	Purpose_Code__c : header.purposeCode,
	Load_Port__c : locationVar.loadPort.loadPortAbbr,
	Load_Port_Description__c : locationVar.loadPort.loadPortDesc,
	Load_Port_State__c : locationVar.loadPort.loadPortSt,
	Load_Port_Country__c : locationVar.loadPort.loadPortCo,
	Load_Port_Date__c : if(!isEmpty(locationVar.loadPort.loadPortDate)) locationVar.loadPort.loadPortDate else null,
	Discharge_Port__c : locationVar.dschPort.dschPortAbbr,
	Discharge_Port_Description__c : locationVar.dschPort.dschPortDesc,
	Discharge_Port_State__c : locationVar.dschPort.dschPortSt,
	Discharge_Port_Country__c : locationVar.dschPort.dschPortCo,
	Dsch_Port_Date__c : if(!isEmpty(locationVar.dschPort.dschPortDate)) locationVar.dschPort.dschPortDate else null,
	BOL_Load_Port__c : locationVar.bolLoadPort.bolLoadPortAbbr,
	BOL_Load_Port_Description__c : locationVar.bolLoadPort.bolLoadPortDesc,
	BOL_Load_Port_State__c : locationVar.bolLoadPort.bolLoadPortSt,
	BOL_Load_Port_Country__c : locationVar.bolLoadPort.bolLoadPortCo,
	BOL_Load_Port_Date__c : if(!isEmpty(locationVar.bolLoadPort.bolLoadPortDate)) locationVar.bolLoadPort.bolLoadPortDate else null,
	BOL_Discharge_Port__c : locationVar.bolDschPort.bolDschPortAbbr,
	BOL_Discharge_Port_Description__c : locationVar.bolDschPort.bolDschPortDesc,
	BOL_Discharge_Port_State__c : locationVar.bolDschPort.bolDschPortSt,
	BOL_Discharge_Port_Country__c : locationVar.bolDschPort.bolDschPortCo,
	Bol_Dsch_Port_Date__c: if(!isEmpty(locationVar.bolDschPort.bolDschPortDate)) locationVar.bolDschPort.bolDschPortDate else null,
	Point_Of_Origin__c: locationVar.blPointOfOrigin.PointOfOriginAbbr,
	Point_Of_Origin_Description__c: locationVar.blPointOfOrigin.PointOfOriginDesc,
	Point_Of_Origin_State__c: locationVar.blPointOfOrigin.PointOfOriginSt,
	Point_Of_Origin_Country__c: locationVar.blPointOfOrigin.PointOfOriginCo,
	Point_Of_Origin_Date__c: if(!isEmpty(locationVar.blPointOfOrigin.PointOfOriginDate)) locationVar.blPointOfOrigin.PointOfOriginDate else null,
	Place_Of_Receipt__c: locationVar.blPlaceOfReceipt.PlaceOfReceiptAbbr,
	Place_Of_Receipt_Description__c: locationVar.blPlaceOfReceipt.PlaceOfReceiptDesc,
	Place_Of_Receipt_State__c: locationVar.blPlaceOfReceipt.PlaceOfReceiptSt,
	Place_Of_Receipt_Country__c: locationVar.blPlaceOfReceipt.PlaceOfReceiptCo,
	Place_Of_Receipt_Date__c: if(!isEmpty(locationVar.blPlaceOfReceipt.PlaceOfReceiptDate)) locationVar.blPlaceOfReceipt.PlaceOfReceiptDate else null,
	Final_Destination__c: locationVar.blFinalDest.finalDestAbbr,
	Final_Destination_Description__c: locationVar.blFinalDest.finalDestDesc,
	Final_Destination_State__c: locationVar.blFinalDest.finalDestSt,
	Final_Destination_Country__c: locationVar.blFinalDest.finalDestCo,
	Final_Dest_Date__c: if(!isEmpty(locationVar.blFinalDest.finalDestDate)) locationVar.blFinalDest.finalDestDate else null,
	Relay_Point__c: locationVar.blRelayPoint.relayPointAbbr,
	Relay_Point_Description__c: locationVar.blRelayPoint.relayPointDesc,
	Relay_Point_State__c: locationVar.blRelayPoint.relayPointSt,
	Relay_Point_Country__c: locationVar.blRelayPoint.relayPointCo,
	Relay_Point_Date__c: if(!isEmpty(locationVar.blRelayPoint.relayPointDate)) locationVar.blRelayPoint.relayPointDate else null,
	BOL_Release_Location__c: locationVar.blReleaseLoc.releaseLocAbbr,
	BOL_Release_Description__c: locationVar.blReleaseLoc.releaseLocDesc,
	BOL_Release_State__c: locationVar.blReleaseLoc.releaseLocSt,
	BOL_Release_Country__c: locationVar.blReleaseLoc.releaseLocCo,
	Place_of_Receipt_1__c: locationVar.overRideValues.placeOfReceiptLn1,
	Place_of_Receipt_2__c: locationVar.overRideValues.placeOfReceiptLn2,
	BOL_Load_Port_1__c: locationVar.overRideValues.bolLoadPortLn1,
	BOL_Load_Port_2__c: locationVar.overRideValues.bolLoadPortLn2,
	BOL_Load_Pier_Terminal_1__c: locationVar.overRideValues.bolLoadPierTermLn1,
	BOL_Load_Pier_Terminal_2__c: locationVar.overRideValues.bolLoadPierTermLn2,
	BOL_Discharge_Port_1__c: locationVar.overRideValues.bolDischPortLn1,
	BOL_Discharge_Port_2__c: locationVar.overRideValues.bolDischPortLn2,
	Place_of_Delivery_1__c: locationVar.overRideValues.placeOfDlvryLn1,
	Place_of_Delivery_2__c: locationVar.overRideValues.placeOfDlvryLn2,
	Voyage_1__c: locationVar.overRideValues.ovrdVoyageLn1,
	Voyage_2__c: locationVar.overRideValues.ovrdVoyageLn2,
	Voyage_3__c: locationVar.overRideValues.ovrdVoyageLn3,
	Voyage_4__c: locationVar.overRideValues.ovrdVoyageLn4,
	Routing_Details__c: payload.billoflading.routings.blRoutingInstr.InstructionLine joinBy ",",
	(payload.billoflading.referenceNumbers.refDetail filter (not (["BN"] contains $.ediReferenceType)) map ((ref,index) ->{
		("$(referenceType(ref.ediReferenceType))" : ref.number) if (!isEmpty(referenceType(ref.ediReferenceType)))
	})),
	Booking_Number__c: payload.bookingid
}

var party= payload.billoflading.parties.party default [] map ((party,index) ->{
	
	Type__c: party."Type",
	Party_Id__c: party.UniqueNbr,
	CVIF__c: party.Cvif,
	CVIF_Location_Code__c: party.CvifLocCd,
	Customer_Location_Type__c: party.custLocationType,
	Customer_Location__c: party.custLocation,
	Name: party.Name,
	Federal_Tax_ID__c: party.defaultFederalTaxId,
	Bill_To__c: party.BillToInd,
	CHB_Number__c: party.ChbNbr,
	FMC__c: party.FmcNbr,
	Address_1__c: party.address1,
	Address_2__c: party.address2,
	City__c: party.city,
	State__c: party.state,
	Zip__c: party.zip,
	Country__c: party.country,
	Reference_Number__c: party.partyReference,
	Address_Line1__c: party.Addresses.address1[0],
	Address_Line2__c: party.Addresses.address2[0],
	Address_Line3__c: party.Addresses.address3[0],
	Address_Line4__c: party.Addresses.address4[0],
	Phone_Number__c: party.Addresses.Phone[0],
	Email_Address__c: if(!isEmpty(party.Addresses.Email[0])) party.Addresses.Email[0] else null

})

var itemDetails= payload.billoflading.billItems.itemDetail default [] map (item,index) -> do {
	
	var itemTextDSC = (payload.billoflading.itemsText.detail filter (($.textType == "DSC") and ($.itemSeq == item.Seq)))[0].txtLines default ""

    var itemTextMKS = (payload.billoflading.itemsText.detail filter (($.textType == "MKS") and ($.itemSeq == item.Seq)))[0].txtLines default ""

	fun splitBySize(str, size) = if ( sizeOf(str) <= size) [str] else [str[0 to size - 1]] ++ splitBySize(str[size to -1], size)
---
{
	Sequence_Number__c: item.Seq,
	Origin_Voyage__c: item.OrigVoy,
	Loading_Port__c: item.LoadPort,
	Loading_Port_Sequence__c: item.LoadPortSeq,
	Discharge_Port__c: item.DschPort,
	Discharge_Port_Sequence__c: item.DschPortSeq,
	Commodity_Code__c: item.CmtyTypeCd,
	Rate_Authority_Type__c: item.RateAuthType,
	Authority_Number__c: item.AuthNbr,
	Unit_Quantity__c: item.UnitQty,
	Unit_of_measure__c: item.Unitofmeasure,
	Foreign_Unit_of_measure__c: item.ForgeinUnitofmeasure,
	Weight__c: item.Weight,
	Weight_Type__c: item.WeightType,
	Weight_Unit_of_measure__c: item.WeightUnitofmeasure,
	Weight_Lbs__c: item.WeightLb,
	Weight_Kgs__c: item.WeightKg,
	Cube__c: item.Cube,
	Cube_Feet__c: item.Cubefeet,
	Cube_Meters__c: item.Cubemeters,
	Schedule_Type__c: item.ScheduleType,
	Schedule_B_Number__c: item.ScheduleBNbr,
	Shipper_Declare_value__c: item.ShiprDeclareValue,
	Equipment_container__c: item.EquipCt,
	Hazardous__c: item.HazInd,
	Move_Type__c: item.MovetypeCd,
	Freight_Type__c: item.FreightType,
	Manifest_Quantity__c: item.ManifestQty,
	Manifest_Unit_of_measure__c: item.ManifestUom,
	Tariff_Line_Item_Harmonized_Code_Chapter__c: item.TliHcChptrHdr,
	Tariff_Line_Item_Harmonized_Code_Sub_Hea__c: item.TliHcSubHdr,
	Tariff_Line_Item_User_Commodity_Number__c: item.TliUserCmdyNbr,
	Tariff_Line_Item_Id__c: item.TliId,
	Tariff_Line_Item_Service_Contract__c: item.TliSrvcCtrt,
	Tariff_Line_Item_Number__c: item.TliNbr,
	Sub_Item_Indicator__c: item.SubItemInd,
	Contract_Number__c: item.ServiceContractNum,
	Item_Metric_Indicator__c: item.itemMetricInd,
	Items_Text_DSC__c: itemTextDSC,
    Items_Text_MKS__c: itemTextMKS
	
}} 

var subItem = payload.billoflading.subItems.detail default [] map(detail, index) -> 
do {
var subItemsText= (payload.billoflading.subItems.subItemsText.stxDetail filter ($.sequence == detail.itemSeq))[0]
---
{
	Item_Sequence__c: detail.itemSeq,
	Item_Unique_Number__c: detail.itemUniqNumber,
	Equipment_Prefix__c: detail.equipPrefix,
	Equipment_Number__c: detail.equipNumber,
	Dock_Receipt_Number__c: detail.dockReceiptNumber,
	Unit_Quantity__c: detail.unitQty,
	Unit_of_measure__c: detail.unitofmeassure,
	Foreign_Unit_of_measure__c: detail.foreignUnitofmeasure,
	Weight__c: detail.weight,
	Weight_Unit_of_measure__c: detail.weightUnitofmeasure,
	Weight_Lbs__c: detail.weightLb,
	Weight_Kgs__c: detail.weightKg,
	Weight_Type__c: detail.weightType,
	Cube__c: detail.cube,
	Cube_Feet__c: detail.cubeFeet,
	Cube_Meter__c: detail.cubeMeter,
	Cube_Unit_of_Measure__c: detail.cubeUnitofmeasure,
	Schedule_Type__c: detail.ScheduleType,
	Schedule_B_Number__c: detail.scheduleBNumber,
	Shipper_Declared_Value__c: detail.shipperDeclararedVal,
	Hazardous__c: detail.hazIndicator,
	Sub_Item_Metric_Indicator__c: detail.subitemMetricInd,
    Sequence_Number__c: subItemsText.sequence,
    Unique_Number__c: subItemsText.uniqueNumber,
	Text_Type__c: subItemsText."type",
	Text_Language__c: subItemsText.language,
	Block_Number__c: subItemsText.blockNumber,
	Text_Lines__c: subItemsText.lines		
}}

var commodity= payload.billoflading.commodities.commodity default [] map(commodity, index) -> {
	
	Item_Sequence__c: commodity.itemSequence,
	Unique_Number__c: commodity.uniqueNumber,
	Equipment_Prefix__c: commodity.equipmentPrefix,
	Equipment_Number__c: commodity.equipmentNumber,
	Cargo_Received_Location__c: commodity.cargoReceivedLocation,
	Dock_Receipt_Number__c: commodity.dockReceiptNumber,
	Description__c: commodity.description,
	Type_Code__c: commodity.typeCode,
	Quantity_value__c: commodity.cargoUnitQty,
	Quantity_Unit_of_Measure__c: commodity.cargoUnitofmeasure,
	Weight_value__c: commodity.cargoItemWeight,
	Weight_Unit_of_Measure__c: commodity.cargoWeightunitofmeasure,
	Weight_Type__c: commodity.cargoWeightType,
	Cube__c: commodity.cargoCube,
	Cargo_Cube_Unit_Of_Measure__c: commodity.cargoCubeUnitofmeasure,
	Military_Move_Code__c: commodity.militaryMoveCode,
	Military_Equipment_Number__c: commodity.militaryEquipmentSeqNumber,
	Military_Transportation_Control_Number__c: commodity.comTransCntlNbr,
	Equipment_Partially_loaded__c: commodity.partialLoadInd,
	Reworked_Equipment_Prefix__c: commodity.comRwKdEquipPrfx,
	Reworked_Equipment_Number__c: commodity.comRwkdEquipNbr,
	Reworked_Port_Code__c: commodity.comRwkdPortCd,
	Commodity_Value__c: commodity.comValue,
	Commodity_Cd_Type__c: commodity.comCmdtyCdType,
	CommodityId__c: commodity.comCmdtyCd,
	Commodity__c: commodity.comCdDesc,
	Year__c: commodity.modelYear,
	Make__c: commodity.make,
	Model__c: commodity.model,
	Color__c: commodity.color,
	VIN__c: commodity.vin,
	UN_NA__c: commodity.hazUnNa,
	Proper_Name__c: commodity.hazProperName,
	Technical_Name__c: commodity.hazTechName,
	Hazmat_Description__c: commodity.hazDescription,
	DOT_Class__c: commodity.hazDotClass,
	Haz_Class_Type__c: commodity.hazClassType,
	IMO_Class__c: commodity.hazImoClass,
	Haz_Sub_Hazard_2__c: commodity.hazSubHazard2,
	Haz_Sub_Hazard_1__c: commodity.hazSubHazard1,
	Package_Group__c: commodity.hazPkgGroup,
	Flashpoint__c: commodity.hazFlashPoint,
	Flash_Temperature_Unit_of_Measure__c: commodity.hazFlashPointUom,
	Limited_Quantity_Indicator__c: commodity.hazLimitedQtyInd,
	PoisonInhaleHazIndicator__c: commodity.hazMpiInd,
	Reported_Quantity__c: commodity.hazReportQtyRequiredInd,
	Reportable_Quantity__c: commodity.hazReportableQty,
	Commodity_Metric_Ind__c: commodity.commodityMetricInd,
	Tariff_Type_Code__c: commodity.tariffTypeCd
}

var voyage= payload.billoflading.voyages.voyage default [] map ((voyage, index) ->{
	
	Voyage_Number__c: voyage.voyage,
	Loading_Port__c: voyage.loadPort,
	Loading_Sequence__c: voyage.loadPortSequence,
	Discharge_Port__c: voyage.dischargePort,
	Discharge_Sequence__c: voyage.dischargePortSequence,
	Final_Destination_Abbreviation__c: voyage.finalDestinationAbbreviation,
	Origin_Voyage__c: voyage.originVoyage,
	Vessel_Abbreviation__c: voyage.vesselAbbreviation,
	Vessel_Name__c: voyage.vesselName,
	Vessel_Lloyds_Code__c: voyage.vesselLloydsCode,
	Vessel_Country_Code__c: voyage.vesselCountryCode,
	Vessel_Owner_SCAC__c: voyage.vesselOwnerScac,
	Estimate_Sail_Date__c: if(!isEmpty(voyage.estimateSailDate)) voyage.estimateSailDate else null,
	Actual_Sail_Date__c: if(!isEmpty(voyage.actualSailDate)) voyage.actualSailDate else null,
	Estimate_Arrival_Date__c: if(!isEmpty(voyage.estimatedArrivalDate)) voyage.estimatedArrivalDate else null,
	Actual_Arrival_Date__c: if(!isEmpty(voyage.actualArrivalDate)) voyage.actualArrivalDate else null
})

var equipment= payload.billoflading.equipments.equipment default [] map ((equipment, index) ->{
	
	Sequence_Id__c: equipment.itemDetailSeq,
	Prefix__c: equipment.prefix,
	Name: equipment.number,
	Category__c: equipment.category,
	Equipment_Length__c: equipment.length,
	Type__c: equipment."type",
	Equipment_Type_Code__c: equipment.equipmentTypeCode,
	Fleet_Category__c: equipment.fleetCategory,
	Status_Code__c: equipment.estatusCode,
	Value_of_Cargo_Weight__c: equipment.cargoWeight,
	Weight_Type__c: equipment.weightType,
	Unit_of_Measure_for_Cargo_Weight__c: equipment.weightUnitofmeasure,
	Tare_Weight__c: equipment.tareWeight,
	Tare_Weight_Unit_Of_Measure__c: equipment.tareWeightUnitofmeasure,
	Cargo_Unit_Quantity__c: equipment.cargoUnitQty,
	Equipment_Cargo_Unit_Of_Measurement__c: equipment.eqpCargoUom,
	Cargo_Cube__c: equipment.cargoCube,
	Cargo_Unit_of_measure__c: equipment.cubeUnitofmeasure,
	Owner_Scac__c: equipment.ownerScac,
	Is_Loaded__c: equipment.isLoaded,
	VGM_Weight_Pounds__c: equipment.vgmWeightLbs,
	VGM_Weight_Kilos__c: equipment.vgmWeightKg,
	VGM_Scale_Weight_Pounds__c: equipment.vgmScaleWeightLbs,
	VMG_Scale_Weight_Kilo__c: equipment.vgmScaleWeightKg,
	VGM_Metric_Indicator__c: equipment.vgmMetricInd,
	VGM_Indicator__c: equipment.vgmInd,
	VGM_Date__c: equipment.vgmDate,
	VGM_Time__c: equipment.vgmTime,
	VMG_Authorized_Person__c: equipment.vgmAuthPerson,
	VMG_Responsible_Party__c: equipment.vgmRespParty,
	Seal_Numbers__c: equipment.seals.sealNbr joinBy ",",
	((0 to 2) map (value) -> do {
	   var current="temperature" ++ value + 1
	    ---
	    {
	    ("Temperature_Type_" ++ (value + 1) ++ "__c"): equipment.temperatures[0]."$(current)"."type",
	    ("Temperature_" ++ (value + 1) ++ "__c"): equipment.temperatures[0]."$(current)"."temp",
	    ("Unit_of_measure_Temperature_" ++ (value + 1) ++ "__c"): equipment.temperatures[0]."$(current)"."uom"
	    }
	})

})

var charge= payload.billoflading.charges.charge default [] map((charge,index) ->{

	Item_Sequence__c: charge.itemSequence,
	Item_Code__c: charge.code,
	Unique_Number__c: charge.uniqueNumber,
	BL_Level_Charge_Indicator__c: charge.chgBlLevelChargeInd,
	Excluded_Charges_Indicator__c: charge.chgXcldChrgInd,
	Item_Name__c: charge.text,
	Party_Code__c: charge.partycd,
	Party_Unique_Number__c: charge.partyUniqueNumber,
	Rate__c: charge.rate,
	RatingResponseBasis__c: charge.rateBasis,
	Rate_Basis_Factor__c: charge.rateBasisFactor,
	Quantity__c: charge.quantity,
	Base_Quantity_Type__c: charge.baseQtyType,
	Foreign_Exchange_Rate__c: charge.foreignExchangeRate,
	Prepaid_Collect__c: charge.prepayCollectCode,
	Currency__c: charge.currencyCode,
	Currency_Option__c: charge.chgCrncyOpt,
	Location_Name__c: charge.paymentLocation.locationName,
	Location_Code__c: charge.paymentLocation.locationCode,
	City__c: charge.paymentLocation.city,
	State__c: charge.paymentLocation.state,
	Country__c: charge.paymentLocation.country

})
---
{
	Bill_Of_Lading__c: billOfLading,
	Party__c: party,
	Bill_Item__c: itemDetails,
	Sub_Item__c: subItem,
	Commodity__c: commodity,
	Voyage__c: voyage,
	Equipment__c: equipment,
	Charge_Line__c: charge
}
