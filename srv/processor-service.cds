using { com.training.incidents as db } from '../db/schema';

service ProcessorService {
    entity Incidents as projection on db.Incidents;
    entity Customers @readonly as projection on db.Customers;
}

annotate ProcessorService.Incidents with @odata.draft.enabled;
