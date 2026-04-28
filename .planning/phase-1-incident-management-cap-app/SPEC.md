# Phase 1 Spec: Incident Management CAP App — Backend

**Locked:** 2026-04-28

## Goal
Build a CAP backend consisting of a CDS data model, an OData V4 service, and sample CSV seed data for an incident management application. The backend will track customers, incidents (with a full lifecycle), incident categories, priorities, and comments on incidents. No UI is in scope for this phase.

## Why
Teams need a structured, queryable backend to record and manage customer-reported incidents through their full lifecycle — from creation to resolution — with categorisation, prioritisation, and threaded comments.

## Data Model

| Entity | Key Fields | Notes |
|---|---|---|
| `Customers` | `ID` (UUID), `name`, `email`, `phone` | Base entity; managed aspect |
| `Incidents` | `ID` (UUID), `title`, `description`, `status_code`, `priority_code`, `category_code`, `customer_ID` | Core entity; managed aspect |
| `Categories` | `code` (String key), `name` | CodeList — e.g. Billing, Technical, Shipping |
| `Priorities` | `code` (String key), `name` | CodeList — Low, Medium, High |
| `Statuses` | `code` (String key), `name` | CodeList — New, In Progress, On Hold, Resolved, Closed |
| `Comments` | `ID` (UUID), `incident_ID`, `text`, `author` | Child of Incident; managed aspect |

## Acceptance Criteria
- [ ] AC1: CDS data model defines all six entities with UUID primary keys (or String keys for CodeLists), correct associations, `managed` aspect on `Customers`, `Incidents`, and `Comments`, and CodeList for `Statuses`, `Priorities`, and `Categories`
- [ ] AC2: An OData V4 CAP service exposes `Customers`, `Incidents`, `Categories`, `Priorities`, `Statuses`, and `Comments` with full CRUD; navigations between entities work (e.g. `Incidents?$expand=comments,category,priority,status,customer`)
- [ ] AC3: Sample CSV seed data is provided for all entities using UUID-format keys/foreign keys, and `cds watch` starts the app locally without errors
- [ ] AC4: Incidents can be filtered by `status_code`, `priority_code`, `category_code`, and `customer_ID` via standard OData `$filter` queries
- [ ] AC5: The project follows CAP best practices — `db/` for data model, `srv/` for service, `package.json` with `@sap/cds` dependency, and SQLite for local development

## Constraints
- OData V4 only
- SQLite for local development (no HANA setup required in this phase)
- Single user role (no authentication/authorization in this phase)
- No Fiori Elements UI in this phase
- All primary keys and foreign keys in CSV files must be in UUID format

## Out of Scope
- SAP Fiori Elements frontend
- User authentication / role-based access control
- Email notifications or SLA tracking
- Deployment to BTP / HANA