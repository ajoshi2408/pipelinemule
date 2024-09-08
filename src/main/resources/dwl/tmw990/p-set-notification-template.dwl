%dw 2.0
import * from dw::core::Strings
output application/json
var ccList = p('notification-system-service.tmw990.cc') splitBy (",")
var ccReceipient = ccList map
{
    "email": $,
    "type": "CC"
}
var toList = p('notification-system-service.tmw990.email') splitBy (",")
var toReceipient = toList map
{
    "email": $,
    "type": "TO"
}
---
{
  "format": "text/html",
  "recipients": toReceipient ++ ccReceipient,
  "subject": "[" ++ upper(p('env')) ++ "] TMW990 to C-Sight Alert",
  "substitutionParameters": [
    {
      "key": "@now",
      "value": "2023-07-19T15:08:00.629Z"
    },
    {
      "key": "@message",
      "value": error.description
    },
    {
      "key": "@integration_name",
      "value": "TMW990 to C-Sight"
    },
    {
      "key": "@error_element",
      "value": error.failingComponent default "Error Element not available"
    }
  ],
  "template": "<!DOCTYPE html><html lang=\"en\"><head><title> {@integration_name} Integration </title></head><body> <br><strong>DateTime</strong> : {@now} <br><strong>Message</strong> : {@message} <br><strong>Error Element</strong> : {@error_element}</body></html>"
}