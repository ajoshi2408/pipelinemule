%dw 2.0
output application/json  
var varLocPurpose = p("cdm.loc.siteUseType") splitBy ","
var nonSupplierParties = payload.parties filter ((lower(not ($.LastUpdateBy) == p("cdm.integration.user"))) and ($.PartyUsageCode contains p("cdm.partyUsageCode")))
---
parties: nonSupplierParties map ((party, partyIndex) ->
 (locations:party.locations filter ((location,locIndex) ->
     do {
     	var SiteUse = location.SiteUse.SiteUseType
     	---
     	if (isEmpty(SiteUse))
     	isEmpty(location.CVIFLocCode) and (location.PartySiteNumber matches /\d{7}-\d{2}/) and (isEmpty(SiteUse -- varLocPurpose)) 
     	else  true
       
     }
 )) ++ party - "locations")