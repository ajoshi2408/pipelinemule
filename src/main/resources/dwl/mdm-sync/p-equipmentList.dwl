%dw 2.0
fun compositeGraph(sObjectName,sObjectExtField,data) = ({
	"compositeRequest": data map ((item, index) -> {
		url: "/services/data/v52.0/sobjects/$(sObjectName)/$(sObjectExtField)/$(item.Name)",
		body: item - 'Equipment_ID_TRIM__c' - 'referenceId',
		method: "PATCH",
		referenceId: item.referenceId
	})
})
fun nullCheck(field) = if ( field != "" ) field else null
fun flagCheck(field) = if ( field == "N" ) false else if ( field == "" ) null else true
var inputData = 
payload map (item,index) -> {
	Name: nullCheck(item."EQUIPMENT_ID"),
	referenceId: nullCheck(item.referenceId),
	Eqt_Type__c: nullCheck(item."EQUIPMENT_TYPE"),
	Last_Movement__c: nullCheck(item."LAST_MOVEMENT"),
	Last_Mvm_Date__c: nullCheck(item."LAST_MVM_DATE"),
	Active__c: flagCheck(item.ACTIVE),
	Leased__c: flagCheck(item.LEASED),
	Lease_Contract__c: nullCheck(item."LEASE_CONTRACT"),
	Master_Contract__c: nullCheck(item."MASTER_CONTRACT"),
	Per_Diem_Rate__c: nullCheck(item."PER_DIEM_RATE"),
	Lease_Start_Date__c: nullCheck(item."LEASE_START_DATE"),
	Fleet_Entry_Date__c: nullCheck(item."FLEET_ENTRY_DATE"),
	Fleet_Exit_Date__c: nullCheck(item."FLEEET_EXIT_DATE"),
	Lease_Type__c: nullCheck(item."LEASE_TYPE"),
	Lessor_Id__c: nullCheck(item."LESSOR_ID"),
	Lessor_Name__c: nullCheck(item."LESSOR_NAME"),
	Lessee_Id__c: nullCheck(item."LESSEE_ID"),
	Lessee_Name__c: nullCheck(item."LESSEE_NAME"),
	ONH_Loc__c: nullCheck(item."ONH_LOC"),
	ONH_Subloc__c: nullCheck(item."ONH_SUBLOC"),
	OFH_Loc__c: nullCheck(item."OFH_LOC"),
	OFH_Subloc__c: nullCheck(item."OFH_SUBLOC"),
	Equipment_ID_TRIM__c: nullCheck(item."EQUIPMENT_ID_TRIM"),
	Reefer_Flag__c: flagCheck(item.REEFERFLAG),
	Wam_Flag__c: nullCheck(item.WAMFLAG),
	Wam_Id__c: nullCheck(item.WAMID),
	Manufacturing_Code__c: nullCheck(item.MANUFCODE),
	Manufacturing_Date__c: nullCheck(item.MANUFDATE)
}
output application/json skipNullOn = "everywhere"
---
[{
	graphId: 1,
	(compositeGraph("Equipment_List__C","Equipment_ID_TRIM__c",inputData))
}]