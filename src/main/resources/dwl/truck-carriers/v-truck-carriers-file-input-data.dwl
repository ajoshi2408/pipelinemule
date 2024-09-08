%dw 2.0
output application/json
fun dcast(indt) = if(isEmpty(indt)) true else ((indt as Date{format: "MM/dd/yyyy"}) is Date default false)

var filterTruckKey = ["SCAC","EP_VALID","CMPY"]
var requireTruckData = payload.UIIACROWLEY.*DATA map ((item, index) -> 
{
            "SCAC": item.SCAC,
            "AL_EXP": item.AL_EXP,
			"GL_EXP": item.GL_EXP,
			"TL_EXP": item.TL_EXP,
			"CR_EXP": item.CR_EXP,
			"AL_EXP_PN": item.AL_EXP_PN,
			"GL_EXP_PN": item.GL_EXP_PN,
			"TL_EXP_PN": item.TL_EXP_PN,
			"CR_EXP_PN": item.CR_EXP_PN,
            "EP_VALID": upper(item.EP_VALID),
			"CMPY": item.CMPY
})

fun filterCorrectData(truckInput,status) = (truckInput filter ((item, index) -> (((valuesOf(item -- filterTruckKey) map dcast($)) map $ contains false) == status) and (!isEmpty(item.SCAC)) and ((item.EP_VALID == "Y") or (item.EP_VALID == "N"))))

fun filterIncorrectData(truckInput,status) = (truckInput filter ((item, index) -> (((valuesOf(item -- filterTruckKey) map dcast($)) map $ contains false) == status) or (isEmpty(item.SCAC)) or ((item.EP_VALID != "Y") and (item.EP_VALID != "N"))))
---
{
    correctTruckData: filterCorrectData(requireTruckData,false) default [],
    incorrectTruckData: filterIncorrectData(requireTruckData,true) default []
}