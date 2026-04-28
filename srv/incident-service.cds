using { incidentmanagement as im } from '../db/schema';

service IncidentService @(path: '/odata/v4/incident') {

  // ─── Core Entities ──────────────────────────────────────────────────────────
  entity Customers as projection on im.Customers;

  entity Incidents as projection on im.Incidents;

  entity Comments as projection on im.Comments;
}