%dw 2.0
fun compositeGraph(sObjectName,sObjectExtField,data) = ({
	"compositeRequest": data map ((item, index) -> {
		url: "/services/data/v52.0/sobjects/$(sObjectName)/$(sObjectExtField)/$(item.Vehicle_Name__c)",
		body: item - 'Vehicle_Name__c' - 'referenceId',
		method: "PATCH",
		referenceId: item.referenceId
	})
})
fun nullCheck(field) = if ( field != "" ) field else null
fun flagCheck(field) = if ( field == "N" ) false else if ( field == "" ) null else true
var inputData = 
 payload map (carportalitem,carportalindex) -> {
 	referenceId: nullCheck(carportalitem.referenceId),
	(Model_Id__c: carportalitem."CarModelID" as String) if carportalitem."CarModelID" !=null,
	Type__c: nullCheck(carportalitem."Type"),
	Model_Year__c: nullCheck(carportalitem."ModelYear"),
	Manufacturer__c: nullCheck(carportalitem."Manufacturer"),
	Model__c: nullCheck(carportalitem."ModelNum"),
	Model_Code__c: nullCheck(carportalitem."ModelCode"),
	Model_Name__c: nullCheck(carportalitem."ModelName"),
	Length__c: nullCheck(carportalitem."LengthCM"),
	Width__c: nullCheck(carportalitem."WidthCM"),
	Height__c: nullCheck(carportalitem."HeightCM"),
	Weight__c: nullCheck(carportalitem."WeightKG"),
	Propulsion__c: nullCheck(carportalitem."Propulsion"),
	Handling_Ind__c: nullCheck(carportalitem."HandlingInd"),
	Hide__c: nullCheck(carportalitem."Hide"),
	Vehicle_Name__c: if ( !isEmpty(carportalitem.Manufacturer) and !isEmpty(carportalitem.ModelCode) ) carportalitem.Manufacturer ++ "-" ++ carportalitem.ModelCode
    else if ( isEmpty(carportalitem.ModelCode) ) carportalitem.Manufacturer
    else if ( isEmpty(carportalitem.Manufacturer) ) carportalitem.ModelCode
    else
      null,
    Name: nullCheck(carportalitem."Manufacturer"),
	RecordType: {
		Name: "Vehicle"
	}
}
output application/json skipNullOn = "everywhere"
---
[{
	graphId: 1,
	(compositeGraph("Substance__c","Vehicle_Name__c",inputData))
}]