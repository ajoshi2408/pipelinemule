%dw 2.0
output application/json  

fun instantMessage(val) =
  (payload.InstantMessagings filter ($.InstantMessengerType) == val map $.InstantMessagingAddress)[0]
var partytype = (payload.PartyType == p("cdm.account.partytype.value"))
var cdmCompanyDesc = if (partytype and not payload.OrgAttribute2 == "")
  payload.OrgAttribute2
else
  payload.PersonAttribute2

---
[
  {
    (Name: payload.PartyName) if not isEmpty(payload.PartyName),
    (AnnualRevenue: payload.AnnualRevenue) if partytype and not isEmpty(payload.AnnualRevenue),
    (Website: payload.PrimaryURL) if not isEmpty(payload.PrimaryURL),
    (Id: (payload.OrigSystemReference filter (upper($.key)) == p("cdm.location.key") map ($.value))[0]) if not isEmpty((payload.OrigSystemReference filter (upper($.key)) == p("cdm.location.key") map ($.value))[0]),
    ("CDM_Org_Id__c": payload.PartyId) if not isEmpty(payload.PartyId),
    ("CEO_Name__c": payload.CeoName) if partytype and not isEmpty(payload.CeoName),
    ("Customer_Status__c": payload.CustomerStatus) if not isEmpty(payload.CustomerStatus),
    ("CVIF__c": payload.CVIFNumber) if partytype and not isEmpty(payload.CVIFNumber),
    ("D_B_Credit_Rating__c": payload.DbRating) if partytype and not isEmpty(payload.DbRating),
    "D_U_N_S_Number__c": 
      if (not isEmpty(payload.DUNSNumber))
        payload.DUNSNumber
      else
        null,
    (NumberOfEmployees: payload.TotalEmployeesText as Number) if partytype and not isEmpty(payload.TotalEmployeesText),
    ("Last_Synched_with_CDM__c": (payload.LastUpdateDate as String {format: "yyyy-MM-dd HH:mm:ss"})[0 to 18]) if not isEmpty(payload.LastUpdateDate),
    ("Line_of_Business__c": payload.LineOfBusiness) if partytype and not isEmpty(payload.LineOfBusiness),
    Type: "Customer",
    ("Privately_Owned__c": payload.PublicPrivateOwnershipFlag as Boolean) if partytype and not isEmpty(payload.PublicPrivateOwnershipFlag),
    ("CDM_Global_Ultimate_DUNS_Number__c": payload.GlobalUltimateDUNSNumber) if not isEmpty(payload.GlobalUltimateDUNSNumber),
    ("CDM_Company_Description__c": cdmCompanyDesc) if not isEmpty(if (partytype and not payload.OrgAttribute2 == "")
		  payload.OrgAttribute2
		else
		  payload.PersonAttribute2),
    ("CDM_Global_Ultimate_Indicator__c": payload.OrgAttribute1) if not isEmpty(payload.OrgAttribute1),
    ("Parent_DUNS_Number__c": payload.ParentDUNSNumber) if not isEmpty(payload.ParentDUNSNumber),
    ("Legal_Name__c": payload.OrgAttribute10) if not isEmpty(payload.OrgAttribute10),
    ("LinkedIn__c": instantMessage("LINKEDIN")) if not isEmpty(instantMessage("LINKEDIN")),
    ("Facebook__c": instantMessage("FACEBOOK")) if not isEmpty(instantMessage("FACEBOOK")),
    ("Twitter__c": instantMessage("TWITTER")) if not isEmpty(instantMessage("TWITTER")),
    ("Email__c": (payload.emails.EmailAddress)[0]) if not isEmpty(payload.emails.EmailAddress),
    ("CDM_Registry_ID__c": payload.PartyNumber) if not isEmpty(payload.PartyNumber),
    "Deactivation_Reason__c": 
      if (not isEmpty(payload.InactivationReasons))
        payload.InactivationReasons
      else
        null,
    ("Reinstatement_Status__c": payload.ReinstatementStatus) if not isEmpty(payload.ReinstatementStatus),
    ("Secondary_Account_CVIF_ID__c": payload.secondaryAccountNumber) if not isEmpty(payload.secondaryAccountNumber),
    "Inactivation_Reasons__c": 
      if (not isEmpty(payload.InactivationReasonsPick))
        payload.InactivationReasonsPick
      else
        null
  }
]