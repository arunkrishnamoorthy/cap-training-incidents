sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/training/ui/manageincidents/test/integration/FirstJourney',
		'com/training/ui/manageincidents/test/integration/pages/IncidentsList',
		'com/training/ui/manageincidents/test/integration/pages/IncidentsObjectPage',
		'com/training/ui/manageincidents/test/integration/pages/ConversationObjectPage'
    ],
    function(JourneyRunner, opaJourney, IncidentsList, IncidentsObjectPage, ConversationObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/training/ui/manageincidents') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheIncidentsList: IncidentsList,
					onTheIncidentsObjectPage: IncidentsObjectPage,
					onTheConversationObjectPage: ConversationObjectPage
                }
            },
            opaJourney.run
        );
    }
);