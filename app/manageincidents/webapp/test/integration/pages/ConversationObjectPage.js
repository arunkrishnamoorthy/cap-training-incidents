sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.training.ui.manageincidents',
            componentId: 'ConversationObjectPage',
            contextPath: '/Incidents/conversation'
        },
        CustomPageDefinitions
    );
});