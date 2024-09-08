%dw 2.0
fun compositeGraph(sObjectName,sObjectExtField,data) = ({
	"compositeRequest": data map ((item, index) -> {
		url: "/services/data/v52.0/sobjects/$(sObjectName)/$(sObjectExtField)/$(item.Location_Name_Unique__c)",
		body: item - 'Location_Name_Unique__c' - 'referenceId',
		method: "PATCH",
		referenceId: item.referenceId
	})
})
fun nullCheck(field) = if ( field != "" ) field else null
fun flagCheck(field) = if ( field == "N" ) false else if ( field == "" ) null else true
var inputData = 
payload map (item,index) -> {
	referenceId: nullCheck(item.referenceId),
	LcCode__c: nullCheck(item.Location),
	Location_Name_Unique__c: nullCheck(item.Sublocation),
	Sub_location_type__c: nullCheck(item."Sublocation Type"),
	SubLocation_Name__c: nullCheck(item."Sublocation Name"),
	Name: nullCheck(item.Sublocation),
	CVIF_now__c: nullCheck(item."CVIF - now"),
	CVIF_future__c: nullCheck(item."CVIF - future"),
	Is_Ramp__c: flagCheck(item."Is Ramp"),
	(Su_Address_Code__c: item.SUADDRESSCODE as String) if nullCheck(item.SUADDRESSCODE) !=null,
	Route_Zip__c: nullCheck(item."Route Zip"),
	Hide__c: flagCheck(item."Hide"),
	AddressText1__c: nullCheck(item."AddressText1"),
	AddressText2__c: nullCheck(item."AddressText2"),
	AddressStreet1__c: nullCheck(item."AddressStreet1"),
	AddressStreet2__c: nullCheck(item."AddressStreet2"),
	AddressStreet3__c: nullCheck(item."AddressStreet3"),
	(City__c: (item."AddressCity" splitBy ",")[0]) if nullCheck(item."AddressCity") !=null,
	AddressSTprovID__c: nullCheck(item."AddressSTprovID"),
	AddressSTabbr__c: nullCheck(item."AddressSTabbr"),
	State__c: nullCheck(item."AddressSTname"),
	ZipCode__c: nullCheck(item."AddressPostalCode"),
	Country_Code__c: nullCheck(item."AddressCountry"),
	UN_Location_Code__c: nullCheck(item."Location"),
	RecordType: {
		"Name": "SubLocation"
	}
}
output application/json skipNullOn = "everywhere"
---
[{
	graphId: 1,
	(compositeGraph("Location__c","Location_Name_Unique__c",inputData))
}]