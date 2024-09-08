%dw 2.0
output application/json
---
vars.statusPayload ++ {
	"sub-status": if (!isEmpty(payload)) ("update-pending") else ("update-complete")
}