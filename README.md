# CAP-Vibe-Coding
CAP Vibe Coding Session
## Set up MCP servers: 

To setup the MCP servers necessary for the session, do the following :
1. run
```bash
npm install -g @ui5/mcp-server @cap-js/mcp-server @sap-ux/fiori-mcp-server
```

2. 
Then copy the following configuration file in Cline MCP server configuration:
```json
{
  "mcpServers": {
    "cds-mcp": {
      "disabled": false,
      "timeout": 60,
      "type": "stdio",
      "command": "node",
      "args": [
        "/home/user/.node_modules_global/lib/node_modules/@cap-js/mcp-server/index.js"
      ],
      "env": {
        "PATH": "/home/user/.asdf/bin:"
      }
    },
    "fiori-mcp": {
      "disabled": false,
      "timeout": 60,
      "type": "stdio",
      "command": "node",
      "args": [
        "/home/user/.node_modules_global/lib/node_modules/@sap-ux/fiori-mcp-server/dist/index.js"
      ],
      "env": {
        "PATH": "/home/user/.asdf/bin:"
      }
    },
    "ui5-mcp": {
      "disabled": false,
      "timeout": 60,
      "type": "stdio",
      "command": "node",
      "args": [
        "/home/user/.node_modules_global/lib/node_modules/@ui5/mcp-server/bin/ui5mcp.js"
      ],
      "env": {
        "PATH": "/home/user/.asdf/bin:"
      }
    }
  }
}
```
