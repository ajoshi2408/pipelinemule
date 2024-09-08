%dw 2.0
output application/json  

var stateCountries = (p("cdm.location.nonUS.stateCountry") splitBy ",") default []
var provinceCountries = (p("cdm.location.nonUS.provinceCountry") splitBy ",") default []

---
payload.locations map (location, indexOfLocation) -> 
  do { var dateActive = if (((not isEmpty(location.EndDateActive)) or location.EndDateActive == p("cdm.location.endDateActive") or (location.EndDateActive >= now() as String {format: "yyyy-MM-dd"})) and location.Status == p("cdm.location.status"))
    true as Boolean
  else 
    false
  var addressLine1 = if ((sizeOf((location.AddressLine1))) > 80)
    location.AddressLine1[0 to 79]
  else
    location.AddressLine1
	---
    {
      ("Active__c": dateActive) if not isEmpty(location.EndDateActive),
      (Name: addressLine1) if not isEmpty(location.AddressLine1),
      "Address_Line_2__c": 
        if (not isEmpty(location.AddressLine2))
          location.AddressLine2
        else
          null,
      "Address_Line_3__c": 
        if ((not isEmpty(location.AddressLine3)) and (not isEmpty(location.Comments)))
          location.Comments ++ "-" ++ location.AddressLine3
        else (if (not isEmpty(location.Comments))
          location.Comments
        else (if (not isEmpty(location.AddressLine3))
          location.AddressLine3
        else
          null)),
      "Address_Line_4__c": if (not isEmpty(location.AddressLine4)) location.AddressLine4 else null,
      ("CDM_Org_Id__c": location.PartyId) if not isEmpty(location.PartyId),
      ("CDM_Location_Id__c": location.PartySiteId) if not isEmpty(location.PartySiteId),
      "City__c": 
        if (not isEmpty(location.City))
          location.City
        else (if (location.Country == p("cdm.location.country"))
          p("cdm.location.city")
        else
          null),
      ("Country__c": location.Country) if not isEmpty(location.Country),
      ("CVIF_Location_Number__c": location.CVIFLocationNumber) if not isEmpty(location.CVIFLocationNumber),
      ("CVIF_Location_Id__c": location.CVIFLocationNumber) if not isEmpty(location.CVIFLocationNumber),
      (Id: location.LocationAttribute9) if not isEmpty(location.LocationAttribute9),
      "Last_Synched_with_CDM__c": now() as String {format: "yyyy-MM-dd HH:mm:ss"},
      ("LocationCode__c": location.CVIFLocCode) if not isEmpty(location.CVIFLocCode),
      ("CDM_Global_Ultimate_DUNS_Number__c": location.LocationAttribute1) if not isEmpty(location.LocationAttribute1),
      ("CDM_Global_Ultimate_Indicator__c": location.LocationAttribute3) if not isEmpty(location.LocationAttribute3),
      ("CDM_Company_Description__c": location.LocationAttribute5) if not isEmpty(location.LocationAttribute5),
      ("CDM_Parent_DUNS_Number__c": location.LocationAttribute2) if not isEmpty(location.LocationAttribute2),
      ("Location_DUNS_Number__c": location.DUNSNumberC) if not isEmpty(location.DUNSNumberC),
      "Postal_Code__c": 
        if (not isEmpty(location.PostalCode))
          location.PostalCode
        else
          null,
      "State_Picklist__c": 
        if ((location.Country == p("cdm.location.value")) and (not isEmpty(location.State)))
          location.State
        else
          null,
      "State_Province__c": 
        if ((stateCountries contains location.Country) and (not isEmpty(location.State)))
          location.State
        else (if ((provinceCountries contains location.Country) and (not isEmpty(location.Province)))
          location.Province
        else
          null),
      (LocationAttribute6: location.LocationAttribute6) if not isEmpty(location.LocationAttribute6),
      ("CDM_Site_Number__c": location.PartySiteNumber) if not isEmpty(location.PartySiteNumber),
      "Deactivation_Reason__c": 
        if (not isEmpty(location.InactivationReasons))
          location.InactivationReasons
        else
          null,
      ("Reinstatement_Status__c": location.ReinstatementStatus) if not isEmpty(location.ReinstatementStatus),
      ("Location_Code_3_Digit__c": location.LocationCode3Digit) if not isEmpty(location.LocationCode3Digit),
      "Inactivation_Reasons__c": 
        if (not isEmpty(location.InactivationReasonsPick))
          location.InactivationReasonsPick
        else
          null,
      "Editable_Fields_Values__c": if (not isEmpty(location.EditLocationRequest)) location.EditLocationRequest else null
    }
}