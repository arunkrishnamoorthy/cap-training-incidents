const cds = require('@sap/cds');

class ProcessorService extends cds.ApplicationService {

    init() {
        
        const { Incidents } = cds.entities;

        this.before('UPDATE', 'Incidents', async (req) => {
            const { ID } = req.data;
            const incident = await SELECT.one.from(Incidents).where({ ID: ID });
            if( incident.status_code === 'C') {
                req.error(501, 'Closed incidents cannot be edited' );
            }
        });

        return super.init();
    }


}

module.exports = { ProcessorService };
