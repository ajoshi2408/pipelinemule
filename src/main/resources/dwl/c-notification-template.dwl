%dw 2.0
output application/json skipNullOn = "everywhere"
var environment = p('env')
var template = vars.notificationTemplate
---
{
	format: template.format,
	recipients: ((template.recipients default []) ++ (payload.ccRecipient default []) ++ (payload.toRecipient default [])) distinctBy ($.email ++ $.'type'),
	subject: "[" ++ upper(environment) ++ "]" ++ template.subject,
	substitutionParameters: template.substitutionParameters map ((substitutionParameter , indexOfSubstitutionParameter) -> 
		{
		key: substitutionParameter.key,
		value: payload[substitutionParameter.key replace /[{@}]/ with ""] default "Value Not Specified"
	}),
	("attachments": payload.fileAttach map ((item, index) -> 
        {
		"name": item.fileName,
		"value": item.fileValue,
		"contenttype": item.contentType
	})) if(!isEmpty(payload.isAttachment)),
	template: template.template
}