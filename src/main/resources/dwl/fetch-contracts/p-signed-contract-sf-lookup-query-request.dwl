%dw 2.0
output application/java
var accountQuery = p('fetchContract.account.lookup.query')
var locSubQuery = p('fetchContract.location.lookup.sub.query')
var locQuery = p('fetchContract.location.lookup.query')
var locDoorQuery = p('fetchContract.location.door.lookup.query')
var polQuery = p('fetchContract.location.pol.lookup.query')
var recordTypeQuery = p('fetchContract.recordType.query') splitBy ("|")
var affiliateIds= (payload.Contracts.OwnerID default [])   ++ (payload.Contracts.Affiliates..AffiliateID default [] )
fun locationfrom(termValue) = flatten (payload.Contracts.LineItems) filter ($.ReceiptTerm == termValue) map ($.LocationFrom)
fun locationto(termValue) = flatten (payload.Contracts.LineItems) filter ($.DeliveryTerm == termValue) map ($.LocationTo)
var pTermIds = locationfrom(p('fetchContract.pterm')) ++ locationto(p('fetchContract.pterm'))
var rTermIds = locationfrom(p('fetchContract.rterm')) ++ locationto(p('fetchContract.rterm'))
var cTermIds = locationfrom(p('fetchContract.cterm')) ++ locationto(p('fetchContract.cterm'))
var dTermIds = locationfrom(p('fetchContract.dterm')) ++ locationto(p('fetchContract.dterm'))
var pLocationType = p('fetchContract.locp')
var rLocationType =p('fetchContract.locr')
var cLocationType = p('fetchContract.locc')
var polIds =( flatten (payload.Contracts.OptionalServiceExceptions)   map ($.POL) )++ (flatten (payload.Contracts.OptionalServiceExceptions)  map ($.POD) )
var developername= if ((payload.Contracts[0].AmendmentNum) ~= 0) p('fetchContract.devstd') else p('fetchContract.devamt')
---

 [
    ({
      method: "GET",
      url: accountQuery ++ " ('" ++ (affiliateIds filter ($ != null) distinctBy $  joinBy ("', '")) ++ "'" ++ ")",
      referenceId: "AccountIds"
    }),
    ({
      method: "GET",
      url:  locQuery ++ " ('" ++ (pTermIds filter ($ != null) distinctBy $  joinBy ("', '")) ++ "'" ++ ") " ++ locSubQuery ++  " ('" ++ pLocationType ++ "')",
      referenceId: "pLocationIds"
    }),
    ({
      method: "GET",
      url: locQuery ++ " ('" ++ (rTermIds filter ($ != null) distinctBy $  joinBy ("', '")) ++ "') " ++ locSubQuery ++  " ('" ++ rLocationType ++ "')",
      referenceId: "rLocationIds"
    }),
    ({
      method: "GET",
      url: locQuery ++ " ('" ++ (cTermIds filter ($ != null) distinctBy $  joinBy ("', '")) ++ "') " ++ locSubQuery ++  " ('" ++ cLocationType ++ "')",
      referenceId: "cLocationIds"
    }),
    ({
      method: "GET",
      url: locDoorQuery ++ " ('" ++ (dTermIds filter ($ != null) distinctBy $ joinBy ("', '")) ++ "') ",
      referenceId: "dLocationIds"
    }),
    ({
      method: "GET",
      url: polQuery ++ " ('" ++ (polIds filter ($ != null) distinctBy $ joinBy ("', '")) ++ "') ",
      referenceId: "polLocationIds"
    }),
    ({
      method: "GET",
      url: recordTypeQuery[0] ++ p('fetchContract.Objcontract') ++ recordTypeQuery[1] ++ developername ++ "'",
      referenceId: "recordTypeIds"
    })
  ]



