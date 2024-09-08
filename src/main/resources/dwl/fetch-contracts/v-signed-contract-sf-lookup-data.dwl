%dw 2.0
output application/json  
var cacheData = {
  Account: vars.sfLookupResponse.accountCache,
  LocationTermP: vars.sfLookupResponse.locationReciptP,
  LocationTermR: vars.sfLookupResponse.locationReciptR,
  LocationTermC: vars.sfLookupResponse.locationReciptC,
  LocationTermD: vars.sfLookupResponse.locationReciptD,
  LocationPOL: vars.sfLookupResponse.locationPol,
  RecordTypeId: vars.sfLookupResponse.recordType,
}
var inputData = payload
fun getPort(inputData, value) =
  inputData.Contracts.."$(value)" default [] filter (not $ == null) reduce (pd, acc = {}) -> acc ++ {
      ((pd)) : cacheData.LocationPOL[?(($."Location_Type__c" ~= p("fetchContract.locp") and $.Name ~= pd))][0].Id
    }
fun getIdsByOwner(inputData) =
  inputData.Contracts.OwnerID default [] reduce (contractId, acc = {}) -> acc ++ {
      ((contractId)) : cacheData.Account[?(($."CVIF__c" ~= contractId))][0].Id
    }
fun getValueByaffiliates(inputData, filedVal) =
  inputData.Contracts..AffiliateID default [] filter (not $ == null) reduce (affId, acc = {}) -> acc ++ {
      ((affId)) : cacheData.Account[?(($."CVIF__c" ~= affId))][0]."$(filedVal)"
    }
fun fromLocationsRecTerm(inputData, termValue, catcheValue) =
  using (lineItemsByReceipt = ((flatten((inputData.Contracts.LineItems default [])))[?(($.ReceiptTerm ~= termValue))] default []))
    lineItemsByReceipt match {
    case lineItem if not lineItem == [] -> lineItem.LocationFrom default [] filter (not $ == null) reduce (lineItem, acc = {}) -> acc ++ {
        ((lineItem)) : catcheValue[?(($.RecordType.DeveloperName ~= p("fetchContract.loc") and $.Name ~= lineItem))][0].Id
      }
    else -> {}
  }
fun fromLocationsRecTermD(inputData) =
  using (lineItemsByReceipt = ((flatten((inputData.Contracts.LineItems default [])))[?(($.ReceiptTerm ~= p("fetchContract.dterm")))] default []))
    lineItemsByReceipt match {
    case lineItem if not lineItem == [] -> lineItem.LocationFrom default [] filter (not $ == null) reduce (lineItem, acc = {}) -> acc ++ {
        ((lineItem)) : cacheData.LocationTermD[?(($.RecordType.DeveloperName ~= p("fetchContract.zip") and $."LcCode__c" ~= lineItem))][0].Id
      }
    else -> {}
  }
fun toLocationsRecTerm(inputData, termValue, catcheValue) =
  using (lineItemsByReceipt = ((flatten((inputData.Contracts.LineItems default [])))[?(($.DeliveryTerm ~= termValue))] default []))
    lineItemsByReceipt match {
    case lineItem if not lineItem == [] -> lineItem.LocationTo default [] filter (not $ == null) reduce (lineItem, acc = {}) -> acc ++ {
        ((lineItem)) : catcheValue[?(($.RecordType.DeveloperName ~= p("fetchContract.loc") and $.Name ~= lineItem))][0].Id
      }
    else -> {}
  }
fun toLocationsRecTermD(inputData) =
  using (lineItemsByReceipt = ((flatten((inputData.Contracts.LineItems default [])))[?(($.DeliveryTerm ~= p("fetchContract.dterm")))] default []))
    lineItemsByReceipt match {
    case lineItem if not lineItem == [] -> lineItem.LocationTo default [] filter (not $ == null) reduce (lineItem, acc = {}) -> acc ++ {
        ((lineItem)) : cacheData.LocationTermD[?(($.RecordType.DeveloperName ~= p("fetchContract.zip") and $."LcCode__c" ~= lineItem))][0].Id
      }
    else -> {}
  }
---
{
  dischargePorts: getPort(inputData, "POD"),
  loadPorts: getPort(inputData, "POL"),
  idsByOwner: getIdsByOwner(inputData),
  idsByAffiliates: getValueByaffiliates(inputData, "Id"),
  namesByaffiliates: getValueByaffiliates(inputData, "Name"),
  fromLocationRecTermP: fromLocationsRecTerm(inputData, "P", cacheData.LocationTermP),
  fromLocationRecTermD: fromLocationsRecTermD(inputData),
  fromLocationRecTermR: fromLocationsRecTerm(inputData, "R", cacheData.LocationTermR),
  fromLocationRecTermC: fromLocationsRecTerm(inputData, "C", cacheData.LocationTermC),
  toLocationRecTermP: toLocationsRecTerm(inputData, "P", cacheData.LocationTermP),
  toLocationRecTermR: toLocationsRecTerm(inputData, "R", cacheData.LocationTermR),
  toLocationRecTermC: toLocationsRecTerm(inputData, "C", cacheData.LocationTermC),
  toLocationRecTermD: toLocationsRecTermD(inputData),
  RecordTypeId : cacheData.RecordTypeId.Id[0]
}