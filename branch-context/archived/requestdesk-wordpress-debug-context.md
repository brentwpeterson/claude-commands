# Resume: WordPress Image Upload Debugging

## SETUP
cd /Users/brent/scripts/CB-Workspace/cb-requestdesk && git checkout feature/wordpress-image-upload

## CRITICAL DISCOVERY
**NEW vs EXISTING Post Workflow Issue Identified**

## VERIFIED WORKING WORKFLOWS

### ✅ NEW Posts Workflow (CONFIRMED WORKING)
- **URL**: http://localhost:3001/posts
- **Process**: Choose Agent (Cucumber Writer) → create blog post → generate post → generate image → publish to wordpress
- **Result**: ✅ "Successfully published to WordPress! Post ID: 20455"
- **Status**: Complete end-to-end success

### ❌ EXISTING Posts Workflow (FAILING)
- **URL**: http://localhost:3001/blog-posts
- **Process**: Navigate to existing post → Generate image → Save image (✅ GREEN SUCCESS) → Send to WordPress (❌ RED FAILURE)
- **Error**: "Failed to upload image to WordPress: All connection attempts failed"
- **Status**: Image generation works, WordPress send fails

## TECHNICAL FIXES COMPLETED
✅ **Agent Lookup Fixed** (`backend/app/routers/knowledge_chunks.py`):
- Fixed collection → agent → WordPress credentials lookup chain
- Resolved "WordPress API key not found" error
- Fixed database reference errors (`collection.update_one()` → `db.knowledge_chunks.update_one()`)

✅ **Architecture Confirmed**:
- Blog posts sync FROM WordPress via "Cucumber Writer" agent
- Agent credentials: API key `spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8`
- WordPress site: https://contentcucumber.local/
- Flow: chunk → collection → agent → WordPress credentials

## CURRENT DEBUGGING STATUS

**Problem**: Why does NEW posts workflow succeed but EXISTING posts workflow fail with same error?

**Key Investigation Points**:
1. **Image Storage Difference**: NEW posts vs EXISTING posts may handle images differently
2. **URL Expiration**: EXISTING posts might use temporary Replicate URLs that have expired
3. **Agent Association**: EXISTING posts might have different agent lookup path

**Next Steps**:
1. Monitor backend logs during user reproduction: `docker logs cb-requestdesk-app-1 -f`
2. Compare image storage between NEW and EXISTING posts
3. Verify agent lookup chain works for both workflows
4. Check for temporary URL expiration issues

## DOCUMENTATION CREATED
- ✅ `documentation/docs/technical/wordpress/VERIFIED-WORKING-WORDPRESS-SEND-WORKFLOW.md`
- ✅ MCP memory storage of verified working process

## IMPORTANT NOTES
- **DO NOT** attempt to "fix" the NEW posts workflow - it works perfectly
- Focus debugging on EXISTING posts workflow only
- Both workflows use same UI modal (`BlogPostImageGenerationModal.tsx`)
- User has demonstrated complete working end-to-end process for NEW posts