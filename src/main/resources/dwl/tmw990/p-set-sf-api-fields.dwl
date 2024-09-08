%dw 2.0
output application/java
var tmwOrderDetails = [{
    Event_Id__c: payload.eventContext.eventId,
    Event_Name__c: payload.eventContext.eventName,
    Event_DateTime_Stamp__c: (if (!isEmpty(payload.eventContext.eventDateTimeStamp)) (payload.eventContext.eventDateTimeStamp as DateTime) else null),
    Message_Type__c: payload.orderTenderResponse.messageType,
    Sender_System_Id__c: payload.orderTenderResponse.senderSystemId,
    Move_Type__c: payload.orderTenderResponse.moveType,
    Order_Number__c: (payload.orderTenderResponse.orderNumber as String),
    Tender_Response__c: payload.orderTenderResponse.tenderResponse,
    Tender_Response_Type__c: payload.orderTenderResponse.tenderResponseType,
    Tender_Response_DateTime__c: (if (!isEmpty(payload.orderTenderResponse.tenderResponseDateTime)) (payload.orderTenderResponse.tenderResponseDateTime as DateTime) else null),
    Equipment_Number__c: if ((!isEmpty(payload.orderTenderResponse.equipmentInfo[0].equipmentPrefix))  and (!isEmpty (payload.orderTenderResponse.equipmentInfo[0].equipmentNumber ))) (payload.orderTenderResponse.equipmentInfo[0].equipmentPrefix ++ payload.orderTenderResponse.equipmentInfo[0].equipmentNumber) else null,
    Total_Charges__c: payload.orderTenderResponse.equipmentInfo[0].totalCharges,
    Booking_Number__c: if ((!isEmpty(payload.orderTenderResponse.booking[0].bookingPrefix)) and (!isEmpty(payload.orderTenderResponse.booking[0].bookingNumber))) (payload.orderTenderResponse.booking[0].bookingPrefix ++ payload.orderTenderResponse.booking[0].bookingNumber) else null,
    Booking_Seq__c: payload.orderTenderResponse.booking[0].bookingSeq,
    Bill_of_Lading_Number__c: payload.orderTenderResponse.booking[0].billOfLading,
    Carrier_SCAC__c: payload.orderTenderResponse.carrier[0].scac
}]
---
tmwOrderDetails