# CDS and FIori Rules


## Rules for cds-mcp
- You must following these guidelines in the plan mode and act mode if there was no prior planning.
- You MUST search for CDS definitions, like entities, fields and services (which include HTTP endpoints) with cds-mcp, only if it fails you MAY read \*.cds files in the project.
- You MUST search for CAP docs with cds-mcp EVERY TIME you create, modify CDS models or when using APIs or the `cds` CLI from CAP. Do NOT propose, suggest or make any changes without first checking it.
- You must always use CodeList for any status, genres or enum types needed in the data models. 
- When creating sample data in CSV files, all primary keys and foreign keys MUST be in UUID format, cuid in cds . Also use the mcp-servers to check the documentation for the naming convention of the csv files.
- Always use the managed aspect for the data entites, to support logging 


## Rules for creation or modification of SAP Fiori elements apps
- Always use the Fiori app generator via the mcp server when creating a UI, if not specfied explicitly otherwise by the user input.
- When asked to create an SAP Fiori elements app check whether the user input can be interpreted as an application organized into one or more pages containing table data or forms, these can be translated into a SAP Fiori elements application, else ask the user for suitable input.
- The application typically starts with a List Report page showing the data of the base entity of the application in a table. Details of a specific table row are shown in the ObjectPage. This first Object Page is therefore based on the base entity of the application.
- An Object Page can contain one or more table sections based on to-many associations of its entity type. The details of a table section row can be shown in an another Object Page based on the associations target entity.
- The data model must be suitable for usage in a SAP Fiori elements frontend application. So there must be one main entity and one or more navigation properties to related entities.
- Each property of an entity must have a proper datatype.
- For all entities in the data model provide primary keys of type UUID.
- When generating or modifying the SAP Fiori elements application on top of the CAP service use the Fiori MCP server if available.
- When attempting to modify the SAP Fiori elements application like adding columns you must not use the screen personalization but instead modify the code of the project, before this first check whether an MCP server provides a suitable function.
- When previewing the SAP Fiori elements application use the most specific script for the app in the `package.json`.
- You mus use ODATA 4.0 for every ODATA endpoint/connection in the frontend.
- When asked to include a fiori launchpad to run locally, follows this: Execute npm install express@4 , then execute  npm add -D cds-launchpad-plugin


