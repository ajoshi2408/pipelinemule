%dw 2.0
fun compositeGraph(sObjectName,sObjectExtField,data) = ({
	"compositeRequest": data map ((item, index) -> {
		url: "/services/data/v52.0/sobjects/$(sObjectName)/$(sObjectExtField)/$(item.IMO_NO__c)",
		body: item - 'IMO_NO__c' - 'referenceId',
		method: "PATCH",
		referenceId: item.referenceId
	})
})
fun nullCheck(field) = if ( field != "" ) field else null
fun flagCheck(field) = if ( field == "N" ) false else if ( field == "" ) null else true
var inputData = 
payload filter ($."IMO NO" !=null and $."IMO NO" !="") map (item,index) -> {
	referenceId: nullCheck(item.referenceId),
	Vessel_Code__c: nullCheck(item."Vessel Code"),
	Name: nullCheck(item."Vessel Name"),
	Call_Sign__c: nullCheck(item."Call Sign"),
	Lloyds_No__c: nullCheck(item."Lloyds No"),
	IMO_NO__c: item."IMO NO",
	MMSI__c: nullCheck(item."MMSI"),
	Home_Port__c: nullCheck(item."Home Port"),
	Nationality__c: nullCheck(item."Nationality"),
	Captain__c: nullCheck(item."Captain"),
	Contact_Means__c: nullCheck(item."Contact Means"),
	Comm_ValidFrom__c: nullCheck(item."Comm ValidFrom"),
	Comm_ValidTo__c: nullCheck(item."Comm ValidTo"),
	Comm_Location__c: nullCheck(item."Comm Location"),
	Comm_Details__c: nullCheck(item."Comm Details"),
	Contact__c: nullCheck(item."Contact"),
	User__c: nullCheck(item."USER"),
	Role__c: nullCheck(item."Role"),
	Remarks__c: nullCheck(item."Remarks"),
	CreatedDate__c: nullCheck(item."Create Date"),
	CreatedBy__c: nullCheck(item."Create User"),
	ModifiedDate__c: nullCheck(item."Change Date"),
	ModifiedBy__c: nullCheck(item."Change User")
}
output application/json skipNullOn = "everywhere"
---
[{
	graphId: 1,
	(compositeGraph("Vessel_Master__c","IMO_NO__c",inputData))
}]