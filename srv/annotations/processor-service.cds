using ProcessorService as service from '../processor-service';

annotate service.Incidents with @(
    UI.HeaderInfo     : {
        Title         : {
            $Type: 'UI.DataField',
            Value: title,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: customer.name,
        },
        TypeName      : 'Incident',
        TypeNamePlural: 'Incidents'
    },
    UI.SelectionFields: [
        status_code,
        urgency_code
    ],
    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: title,
        },
        {
            $Type: 'UI.DataField',
            Value: customer_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: status_code,
        },
        {
            $Type: 'UI.DataField',
            Value: urgency_code,
        }
    ],
    UI.Facets         : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'idOverview',
        Label : 'Overview',
        Target: '@UI.FieldGroup#overview',
    }, 
    {
        $Type : 'UI.ReferenceFacet',
        ID : 'idConversation',
        Target : 'conversation/@UI.LineItem#conversationTable',
        Label : 'Conversations',
        
    },
    ]
);

annotate service.Incidents with @(UI.FieldGroup #overview: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
            $Type: 'UI.DataField',
            Value: title,
        },
        {
            $Type: 'UI.DataField',
            Value: customer_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: status_code,
        },
        {
            $Type: 'UI.DataField',
            Value: urgency_code,
        },
    ],
});


annotate service.Conversation with @(
    UI.LineItem #conversationTable: [
       {
           $Type : 'UI.DataField',
           Value : timestamp,
       },
       {
           $Type : 'UI.DataField',
           Value : author,
       },
       {
           $Type : 'UI.DataField',
           Value : message,
       },
    ],
    UI.FieldGroup: {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : message,
            },
        ],
    }
);



annotate service.Incidents with {

    customer @Common : {  
        Text: customer.name,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
               {
                   $Type : 'Common.ValueListParameterInOut',
                   LocalDataProperty : customer_ID,
                   ValueListProperty : 'ID',
               },
               {
                   $Type : 'Common.ValueListParameterDisplayOnly',
                   ValueListProperty : 'name',
               },
               {
                   $Type : 'Common.ValueListParameterDisplayOnly',
                   ValueListProperty : 'email',
               }
            ],
        },
    };

    status   @Common: {
        Text                    : status.name,
        ValueListWithFixedValues: true
    };
    urgency  @Common: {
        Text                    : urgency.name,
        ValueListWithFixedValues: true
    }
}

annotate service.Status with {
    code @Common: {Text: name}
};
