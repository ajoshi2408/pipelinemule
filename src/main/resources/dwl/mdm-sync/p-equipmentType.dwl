%dw 2.0
fun compositeGraph(sObjectName,sObjectExtField,data) = ({
	"compositeRequest": data map ((item, index) -> {
		url: "/services/data/v52.0/sobjects/$(sObjectName)/$(sObjectExtField)/$(item.Name)",
		body: item - 'Name' - 'referenceId',
		method: "PATCH",
		referenceId: item.referenceId
	})
})
fun nullCheck(field) = if ( field != "" ) field else null
fun flagCheck(field) = if ( field == "N" ) false else if ( field == "" ) null else true
var inputData = 
payload map (item,index) -> {
	referenceId: nullCheck(item.referenceId),
	Name: nullCheck(item."SizeType"),
	EQ_Group__c: nullCheck(item."EQGroup"),
	Description__c: nullCheck(item."Description"),
	ISO_Code__c: nullCheck(item."ISOcode"),
	Size_FT__c: nullCheck(item."SizeFT"),
	Type__c: nullCheck(item."Type"),
	Is_Container__c: flagCheck(item."IsContainer"),
	Is_Chassis__c: flagCheck(item."IsChassis"),
	Is_Reefer__c: flagCheck(item."IsReefer"),
	Handle_As__c: nullCheck(item."HandleAs"),
	Is_Genset__c: flagCheck(item."IsGenSet"),
	Genset_Type__c: nullCheck(item."GenSetType"),
	Height_FT__c: nullCheck(item."HeightFT"),
	Width_FT__c: nullCheck(item."WidthFT"),
	Tare_Weight_KG__c: nullCheck(item."TareWeightKG"),
	Heavy_Weight_KG__c: nullCheck(item."HeavyWeightKG"),
	Max_Weight_KG__c: nullCheck(item."MaxWeightKG"),
	Hide__c: flagCheck(item."Hide")
}
output application/json skipNullOn = "everywhere"
---
[{
	graphId: 1,
	(compositeGraph("Equipment_Size_Type__c","Name",inputData))
}]