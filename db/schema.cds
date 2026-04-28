namespace incidentmanagement;

using { cuid, managed } from '@sap/cds/common';
using { sap.common.CodeList } from '@sap/cds/common';

// ─── CodeList Entities ────────────────────────────────────────────────────────

entity Statuses : CodeList {
  key code : String(20);
}

entity Priorities : CodeList {
  key code : String(20);
}

entity Categories : CodeList {
  key code : String(20);
}

// ─── Core Entities ────────────────────────────────────────────────────────────

entity Customers : cuid, managed {
  name      : String(100) @mandatory;
  email     : String(255);
  phone     : String(30);
  incidents : Composition of many Incidents on incidents.customer = $self;
}

entity Incidents : cuid, managed {
  title       : String(200) @mandatory;
  description : String(1000);
  customer    : Association to Customers;
  status      : Association to Statuses;
  priority    : Association to Priorities;
  category    : Association to Categories;
  comments    : Composition of many Comments on comments.incident = $self;
}

entity Comments : cuid, managed {
  text     : String(1000) @mandatory;
  author   : String(100);
  incident : Association to Incidents;
}