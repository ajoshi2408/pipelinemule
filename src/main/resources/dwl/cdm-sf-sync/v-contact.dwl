%dw 2.0
output application/json  skipNullOn="everywhere"

---
(payload.relationships map (relationship, indexOfrelationship) -> {
  (relationship.OrganizationContact map (orgContact, indexOfOrgContact) -> {
    Action: if (not isEmpty(relationship.Action)) relationship.Action else null ,
    "CDM_Contact_Id__c": if (not isEmpty(relationship.ObjectId)) relationship.ObjectId else null,
    FirstName: if (not isEmpty(orgContact.FirstName)) orgContact.FirstName else null,
    LastName: if (not isEmpty(orgContact.LastName)) orgContact.LastName else null,
    MiddleName: if (not isEmpty(orgContact.MiddleName)) orgContact.MiddleName else null,
    Email: if (not isEmpty(relationship.ObjectEmailAddress)) relationship.ObjectEmailAddress else null,
    Phone: (orgContact.ContactPhones filter $.PhoneLineType == p("cdm.contact.PhoneLineType"))[0].FormattedPhoneNumber default null,
    MobilePhone: (orgContact.ContactPhones filter $.PhoneLineType == p("cdm.contact.MPhoneLineType"))[0].FormattedPhoneNumber default null,
    "Contact_Type__c": if (not isEmpty(orgContact.Department)) orgContact.Department else null,
    Id: if (not isEmpty(orgContact.SFIDContact)) orgContact.SFIDContact else null,
    "CDM_Location_Id__c": if (not isEmpty(orgContact.ContactAttribute1Id)) orgContact.ContactAttribute1Id else null,
    "Primary_Phone_Type__c": 
      if (isEmpty(orgContact.ContactPhones))
        null
      else (if (((orgContact.ContactPhones filter $.PrimaryFlag == p("cdm.contact.flagvalue")).PhoneLineType joinBy "") == p("cdm.contact.PhoneLineType"))
        p("cdm.contact.workphone")
      else
        p("cdm.contact.MPhoneLineType")),
    "ContactAttribute1_Id": if (not isEmpty(orgContact.ContactAttribute1Id)) orgContact.ContactAttribute1Id else null,
    "CDM_Contact_Registry_ID__c": if (not isEmpty(orgContact.PartyNumber)) orgContact.PartyNumber else null,
    "Contact_Type__c": if (not isEmpty(orgContact.ContactRoles)) (orgContact.ContactRoles replace (",") with (";")) else null
  })
}) filter ($.Action == "Update")