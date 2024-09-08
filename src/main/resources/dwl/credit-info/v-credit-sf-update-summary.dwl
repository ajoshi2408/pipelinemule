%dw 2.0
output application/java
---
{
	totalRecords: sizeOf(vars.sfUpdatePayload) default 0,
	failedRecords: sizeOf(vars.sfUpdateResponse filter ($.success == false) default []) default 0,
	successRecords: sizeOf(vars.sfUpdateResponse filter ($.success == true) default []) default 0
}