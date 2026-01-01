# WordPress Featured Image URL Fix - Session Context

## 🎯 CURRENT STATUS: 
**DEBUGGING IN PROGRESS** - Found why featured_image_url not being stored

## 🔍 ROOT CAUSE DISCOVERED:
WordPress fields not reaching ShopifyContentService at all!

**Debug Evidence:**
- Document keys: ['title', 'content', 'source_id', 'source_type', 'url', 'metadata']  
- Expected: ['featured_image_url', 'author', 'wordpress_post_id', ...]
- **MISSING**: All WordPress top-level fields

## 🛠️ FIXES ATTEMPTED:
1. ✅ **WordPress Plugin**: Working perfectly - sends featured_image_url in payload
2. ✅ **RequestDesk Backend**: Added WordPress field preservation to ShopifyContentService
3. ❌ **API Filtering Issue**: WordPress fields being lost somewhere between /api/rag/documents endpoint and ShopifyContentService

## 📊 EVIDENCE:
- WordPress debug log shows: 'featured_image_url': 'https://...' in payload 
- RequestDesk debug shows: Document keys missing featured_image_url
- API call succeeds but fields stripped before processing

## 🔧 NEXT STEPS:
1. **Debug /api/rag/documents endpoint** - Check if DocumentsRequest model filters out WordPress fields
2. **Fix DocumentModel Pydantic schema** to allow extra WordPress fields  
3. **Test complete end-to-end flow**

## 💾 FILES MODIFIED:
- `cb-wordpress/includes/class-requestdesk-push.php`: Added featured_image_url (WORKING ✅)
- `cb-requestdesk/backend/app/services/shopify_content_service.py`: Added WordPress field preservation + debug logging

## 🧪 TEST COMMANDS:
- WordPress: v2.2.7 with debug logging enabled
- RequestDesk: Debug test script at `/backend/tests/curl_scripts/wordpress/test-debug-v3.sh`
- Credentials: cucumber/test1234, API key: spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8

**COMMIT**: cb-requestdesk a81c6532 (backend fix applied, needs API model fix)
