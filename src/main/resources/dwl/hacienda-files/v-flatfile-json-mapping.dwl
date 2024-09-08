%dw 2.0
output application/json indent=false
var haciendaInput = vars.haciendaPayload
---
{
	"HaciendaStatus": {
		"headerInfo": {
			"recordType": 1,
			"messageDateTime" : now() >> "GMT",
			"lotNumber" : haciendaInput.HEADER_RECORD."LOT NUMBER",
			"unloadDate" : haciendaInput.HEADER_RECORD."INTRODUCTION DATE",
			"vesselName" : haciendaInput.HEADER_RECORD."VESSEL NAME",
			"voyageNumber" : haciendaInput.HEADER_RECORD."VOYAGE NUMBER"
		},
		"detailRecords" : haciendaInput.DETAIL_RECORD map 
		{
			"details" : {
				"recordType" : 2,
				"equipNumber" : $."CONTAINER NUMBER",
				"dockReceiptNumber" : "",
				"bolNumber" : $."BILL OF LADING",
				"releaseNumber" : $."RELEASE NUMBER",
				"taxIndicator" : if($."RELEASE NUMBER" == 0) "T" else "R",
				"consigneeName" : $."CONSIGNEE NAME"
			}
			
		}
	}
}