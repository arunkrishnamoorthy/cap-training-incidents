namespace com.training.incidents;

using
{
    cuid,
    managed,
    sap.common.CodeList
}
from '@sap/cds/common';

type EmailAddress: String;
type PhoneNumber : String;
type User : String(255);

/***
 * Master Data
 */
entity Customers : managed
{
    key ID : String @title : 'Customer ID';
    firstName : String(50) @title : 'First Name';
    lastName : String(50) @title : 'Last Name';
    name:  String = firstName || ' ' || lastName @title : 'Name';
    email: EmailAddress @title : 'E-Mail Address';
    phone: PhoneNumber @title: 'Phone Number';
    creditCardNo: String(16) @assert.format : '^[1-9]\d{15}' @title : 'Credit Card Number';
}


entity Status: CodeList {
    key code: String enum {
        new = 'N';
        assigned = 'A';
        closed = 'C';
        on_hold = 'H';
        in_process = 'I';
        resolved = 'R';
    };
        criticality: Integer @title : 'Criticality';       
}

entity Urgency: CodeList {
    key code: String enum {
        high = 'H';
        medium = 'M';
        low = 'L';
    };
}

/***
 * Transaction Data
 */
 entity Incidents: cuid, managed {
    title: String @title : '{i18n>incident_title}';
    customer: Association to Customers @title: 'Customer';
    status: Association to Status @title : 'Status';
    urgency: Association to Urgency @title : 'Urgency';
    conversation: Composition of many Conversation @title: 'Conversation';
 }

 entity Conversation: cuid {
    timestamp: type of managed:createdAt;
    author: type of managed:createdBy;
    message: String;
 }

