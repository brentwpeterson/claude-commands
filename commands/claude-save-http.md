🚫 **DEPRECATED COMMAND - Use `/claude-save-mcp` Instead**

**⚠️ THIS COMMAND IS DEPRECATED**

**USAGE:** ~~`/claude-save-http <project>`~~ → **Use `/claude-save-mcp <project>` instead**

**🎯 DEPRECATION NOTICE:**
This command was created for multi-window HTTP OpenMemory usage, but is now obsolete because:
- ✅ **Official Anthropic MCP Memory Server** provides multi-window safety
- ✅ **Knowledge graph storage** eliminates SQLite locking issues
- ✅ **No external HTTP server required** - built into Claude Code

**🔄 MIGRATION GUIDE:**

| Old (Deprecated) | New (Recommended) |
|------------------|-------------------|
| `/claude-save-http <project>` | `/claude-save-mcp <project>` |
| HTTP OpenMemory (port 8080) | Official MCP Memory Server |
| External server dependency | Built-in to Claude Code |
| SQLite with HTTP wrapper | Knowledge graph (no SQLite) |

**🚀 BENEFITS OF OFFICIAL MCP:**
- **Multi-window safe** - No database locking
- **Zero setup** - No external servers to start
- **Anthropic supported** - Official implementation
- **Knowledge graph** - Better than SQLite storage

**📋 COMMAND MIGRATION:**
- **Before**: `/claude-save-http wordpress` (required HTTP server)
- **After**: `/claude-save-mcp wordpress` (works immediately)

**⚠️ END OF DEPRECATED COMMAND**

*The rest of this file contains the old HTTP OpenMemory workflow which is no longer needed. Use `/claude-save-mcp` for the current official implementation.*
1. **Test HTTP OpenMemory Server:**
   - **Check server availability:**
     ```bash
     curl -s http://localhost:8080/health 2>/dev/null
     ```
   - **Expected result:** Should return server health status with "ok": true
   - **If server fails:**
     ```
     ❌ HTTP OpenMemory Server Connection Failed!

     🔧 Start the server:
     cd /Users/brent/scripts/OpenMemory/backend && npm run dev

     ⏸️ STOPPING SAVE - Start HTTP server first, then retry /claude-save-http
     ```
   - **If server succeeds:**
     ```
     ✅ HTTP OpenMemory Server Connected Successfully!
     🌐 Multi-window safe memory storage ready
     📋 Proceeding with HTTP-based save workflow...
     ```

2. **Test Memory Operations:**
   ```bash
   cd /Users/brent/scripts/CB-Workspace/cb-memory-system
   ./scripts/store-memory.sh "Test HTTP connection" '["test", "connection"]'
   ./scripts/query-memory.sh "test connection" 1
   ```
   - **Report status:** "🌐 HTTP API fully operational - memory storage/retrieval confirmed"

**Phase 1-4: [Same as claude-save-mcp]**
[Include all the same phases for work preservation, todo verification, instruction creation, and context commit]

**Phase 5: HTTP-Only Memory Storage**
5. **Store Session Summary via HTTP API:**
   - **🌐 HTTP API ONLY - Multi-Window Safe:**
     ```bash
     cd /Users/brent/scripts/CB-Workspace/cb-memory-system
     ./scripts/store-memory.sh "Session saved for [project] on [branch]. [What was accomplished]. [Current focus]. [Next priority]." \
       '["session:YYYY-MM-DD", "project:[name]", "branch:[name]", "context-save", "http-verified"]'
     ```

   - **Verify storage:**
     ```bash
     ./scripts/query-memory.sh "session:YYYY-MM-DD project:[name]" 1
     ```

   - **Success confirmation:**
     ```
     ✅ Session stored to OpenMemory via HTTP API
     🌐 Multi-window safe storage confirmed
     🔍 Searchable via: ./scripts/query-memory.sh or HTTP API
     ℹ️ Safe to use in multiple Claude Code windows simultaneously
     ```

6. **END BY SHOWING CONTEXT FILE PATH:**
   - Display: "📁 Resume instructions saved to: `.claude/branch-context/[branch-name]-context.md`"
   - **HTTP Status**: "🌐 ✅ Session stored via HTTP API - Multi-window Safe"
   - **Multi-Window Ready**: "⚡ Safe for concurrent Claude Code sessions"

**🎯 KEY FEATURES:**
- **🌐 HTTP-based storage** - No SQLite locking issues
- **🖥️ Multi-window safe** - Multiple Claude Code instances can run simultaneously
- **🔍 Pre-flight verification** - Tests HTTP server before any operations
- **🛡️ Fail-fast design** - Stops if HTTP server isn't available
- **📡 Network-based** - Uses HTTP API instead of direct database access

**📊 COMMAND COMPARISON:**

| Command | Storage Method | Multi-Window Safe | Database Locking |
|---------|----------------|-------------------|------------------|
| `/claude-save` | File + HTTP fallback | ✅ Yes | ❌ Possible with MCP |
| `/claude-save-mcp` | MCP only | ❌ No | ❌ SQLite locks |
| `/claude-save-http` | HTTP only | ✅ Yes | ✅ No locking |

**🚀 WHEN TO USE `/claude-save-http`:**
- **Multiple Claude Code windows** - Primary use case
- **Team development** - Multiple developers sharing OpenMemory server
- **Guaranteed memory** - When you need intelligent storage without MCP complications
- **Network deployment** - When OpenMemory server is on different machine

**🚀 RECOMMENDED WORKFLOW FOR MULTI-WINDOW:**
1. **Terminal**: `cd /Users/brent/scripts/OpenMemory/backend && npm run dev`
2. **All Claude Code windows**: Use `/claude-save-http <project>`
3. **Resume**: Regular `/claude-start <project>` works with any save method