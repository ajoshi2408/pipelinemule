%dw 2.0
output application/java
---
{
	accountCache: (vars.aggregatedCompositeResponse filter $.referenceId == "AccountIds").body.records[0],
	locationReciptP: (vars.aggregatedCompositeResponse filter $.referenceId == "pLocationIds").body.records[0],
	locationReciptR: (vars.aggregatedCompositeResponse filter $.referenceId == "rLocationIds").body.records[0],
	locationReciptC: (vars.aggregatedCompositeResponse filter $.referenceId == "cLocationIds").body.records[0],
	locationReciptD: (vars.aggregatedCompositeResponse filter $.referenceId == "dLocationIds").body.records[0],
	locationPol: (vars.aggregatedCompositeResponse filter $.referenceId == "polLocationIds").body.records[0],
	recordType: (vars.aggregatedCompositeResponse filter $.referenceId == "recordTypeIds").body.records[0]
}