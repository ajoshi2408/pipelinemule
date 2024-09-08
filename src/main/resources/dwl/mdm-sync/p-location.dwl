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
payload filter ($."Location Type" != "HIDE" and $."Location Type" != "SCHCOR" and $."Location Type" != "ISL" and $."Location Type" != "OFFHIRE" and $."Location Type" != "OTHER" and $."Location Type" != "" and $."Location Type" != null) map (item, index) -> {
	referenceId: nullCheck(item.referenceId),
	(Country_Code__c: item."Country Code") if (nullCheck(item."Country Code") != null),
	(City__c: (item."City" splitBy ",")[0]) if (nullCheck(item."City") != null),
	(Country_Name__c: item."Country Name") if (nullCheck(item."Country Name") != null),
	(Location_Name__c: item."Location Name") if (nullCheck(item."Location Name") != null),
	(Name: if ( (upper(item."Location Type")) == "ZIPCODE" ) item."Zipcode"    else      item."Location Code") if (nullCheck(item."Location Code") != null),
	Location_Type__c: if ( (upper(item."Location Type")) == "ZIPCODE" ) "DOOR"    else      item."Location Type",
	(State_Code__c: item."State Code") if (nullCheck(item."State Code") != null),
	(State__c: item."State Name") if (nullCheck(item."State Name") != null),
	(ZipCode__c: item."Zipcode") if (nullCheck(item."Zipcode") != null),
	Location_Name_Unique__c: if ( nullCheck(item."Location Code") !=null ) (if ( upper (item."Location Type") == "ZIPCODE" ) item."Location Code" ++ "-" ++ "DOOR" else item."Location Code" ++ "-" ++ item."Location Type")    else     item."Location Type",
	(LcCode__c: item."Location Code") if (nullCheck(item."Location Code") != null),
	Locked__c: (if ( item."Locked" == "Y" ) true    else      false),
	Dummy__c: (if ( item."Dummy" == "Y" ) true    else      false),
	(Firma__c: item."Firma") if (nullCheck(item."Firma") != null),
	(GMT_Offset__c: item."Time Zone - GMT Offset") if (nullCheck(item."Time Zone - GMT Offset") != null),
	(SDST_Day_of_Week_Sequence__c: item."Start Daylight Saving Time - Day of Week Sequence"[0 to 1]) if (nullCheck(item."Start Daylight Saving Time - Day of Week Sequence") != null),
	(SDST_Day_of_Week__c: item."Start Daylight Saving Time - Day of Week"[0 to 1]) if (nullCheck(item."Start Daylight Saving Time - Day of Week") != null),
	(SDST_Month__c: item."Start Daylight Saving Time - Month"[0 to 1]) if (nullCheck(item."Start Daylight Saving Time - Month") != null),
	(EDST_Day_of_Week_Sequence__c: item."End Day light Saving Time - Day of Week Sequence"[0 to 1]) if (nullCheck(item."End Day light Saving Time - Day of Week Sequence") != null),
	(EDST_Day_of_Week__c: item."End Day light Saving Time - Day of Week"[0 to 1]) if (nullCheck(item."End Day light Saving Time - Day of Week") != null),
	(EDST_Month__c: item."End Day light Saving Time - Month"[0 to 1]) if (nullCheck(item."End Day light Saving Time - Month") != null),
	(Location_Altname__c: item."LOCATION_ALTNAME") if (nullCheck(item."LOCATION_ALTNAME") != null),
	(Geolocation__Latitude__s: item."Latitude") if (nullCheck(item."Latitude") != null),
	(Geolocation__Longitude__s: item."Longitude") if (nullCheck(item."Longitude") != null),
	(LocationCode__c: item."Location Code") if (nullCheck(item."Location Code") != null),
	RecordType: {
		Name: if ( (upper(item."Location Type")) == "ZIPCODE" ) "ZipCode"      else        "Location"
	}
}
output application/json skipNullOn = "everywhere"
---
[{
	graphId: 1,
	(compositeGraph("Location__c","Location_Name_Unique__c",inputData))
}]