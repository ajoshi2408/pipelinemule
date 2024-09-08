%dw 2.0
fun dwlFileName(value) = value match {
    case "vesselDetails"  -> readUrl('classpath://dwl/mdm-sync/p-vesselDetails.dwl', 'text/plain')
    case "portalCarModel" -> readUrl('classpath://dwl/mdm-sync/p-portalCarModel.dwl', 'text/plain')
    case "subLocation"    -> readUrl('classpath://dwl/mdm-sync/p-subLocation.dwl', 'text/plain')
    case "location"       -> readUrl('classpath://dwl/mdm-sync/p-location.dwl', 'text/plain')
    case "equipmentList"  -> readUrl('classpath://dwl/mdm-sync/p-equipmentList.dwl', 'text/plain')
    case "equipmentType"  -> readUrl('classpath://dwl/mdm-sync/p-equipmentType.dwl', 'text/plain')
    else  -> value default " " ++ " entity does not exist !!!"
  }
output text/plain
---
dwlFileName(attributes.headers.entity)