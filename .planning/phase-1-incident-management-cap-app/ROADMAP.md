# Phase 1 Roadmap: Incident Management CAP App — Backend

**Created:** 2026-04-28
**Tasks:** 5/5 complete

| Task | Description | Depends On | Acceptance Criteria | Status |
|------|-------------|------------|---------------------|--------|
| 1 | Scaffold CAP project structure and install dependencies | None | - `package.json` exists with `@sap/cds` and `@sap/cds-dk` dependencies<br>- `db/` and `srv/` directories exist<br>- `cds` CLI is available and `cds version` runs without error | ✅ Done |
| 2 | Define CDS data model (entities, CodeLists, associations, managed aspects) | 1 | - `db/schema.cds` defines `Customers`, `Incidents`, `Categories`, `Priorities`, `Statuses`, `Comments`<br>- `Categories`, `Priorities`, `Statuses` use `CodeList` from `@sap/cds/common`<br>- `Incidents` and `Comments` use the `managed` aspect<br>- All entities have UUID primary keys (String keys for CodeLists)<br>- `Incidents` has associations to `Customers`, `Categories`, `Priorities`, `Statuses`<br>- `Comments` has an association to `Incidents` | ✅ Done |
| 3 | Define OData V4 CAP service exposing all entities | 2 | - `srv/incident-service.cds` exposes all entities<br>- Service is annotated for OData V4<br>- `$expand` works for `Incidents` navigating to `customer`, `category`, `priority`, `status`, `comments`<br>- Full CRUD is available on all exposed entities | ✅ Done |
| 4 | Create sample CSV seed data for all entities | 2 | - CSV files exist under `db/data/` following CAP naming convention (`<namespace>-<Entity>.csv`)<br>- All primary keys and foreign keys are in UUID format<br>- At least 3 customers, 3 categories, 3 priorities, 5 statuses, 5 incidents, and 5 comments are seeded<br>- `cds deploy --to sqlite` populates the database without errors | ✅ Done |
| 5 | Verify app starts and OData queries work | 3, 4 | - `cds watch` starts without errors and serves the OData endpoint<br>- `GET /odata/v4/incident/Incidents?$expand=customer,category,priority,status,comments` returns data<br>- `GET /odata/v4/incident/Incidents?$filter=priority_code eq 'H'` returns filtered results<br>- All five spec acceptance criteria (AC1–AC5) are met | ✅ Done |