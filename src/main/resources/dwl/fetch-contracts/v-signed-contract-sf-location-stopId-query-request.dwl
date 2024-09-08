%dw 2.0
output application/java
---
 if ((sizeOf (flatten (payload.Contracts.LineItems..StopOvers filter (not $== null)  default []))) > 0 ) (((flatten (payload.Contracts.LineItems..StopOvers filter (not $== null)) 
 	groupBy ($.StopLocation)
 ) pluck (value,key,index) -> [key] ++ ((value.StopLocation filter (not $== null)  default []) ++ (value.StopSubLocation filter (not $== null)  default [])) distinctBy $) 
 reduce ((item, acc="") -> acc ++ "OR (LcCode__c='" ++ item[0] ++ "' AND (name='" ++ (item[1 to -1] joinBy "' OR name='" ) ++ "'))"))[2 to -1] else null