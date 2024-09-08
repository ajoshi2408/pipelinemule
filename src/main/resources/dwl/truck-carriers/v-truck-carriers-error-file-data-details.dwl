%dw 2.0
output text/plain
var inputHeader = ["Incorrect File Data List: ", "Error Occurred in SalesForce: "]
var incorrectData = if ( !isEmpty(vars.fileInput.incorrectTruckData) ) (inputHeader[0] ++ "\n\n" ++ write(vars.fileInput.incorrectTruckData default [], "application/csv", {
	separator: ','
})) else (inputHeader[0] ++ "No Data Found.")
var sfError = if ( !isEmpty(vars.sfErrorResponse) ) (inputHeader[1] ++ "\n\n" ++ write(vars.sfErrorResponse default [], "application/csv", {
	separator: ','
})) else (inputHeader[1] ++ "No Data Found.")
---
(incorrectData ++ "\n\n" ++ sfError)