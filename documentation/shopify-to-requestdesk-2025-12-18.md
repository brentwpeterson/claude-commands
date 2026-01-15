# Cross-Project Handoff: cb-shopify → cb-requestdesk

**Date:** 2025-12-18
**From:** cb-shopify Claude
**To:** cb-requestdesk Claude

---

## ✅ GADGET ENDPOINTS READY

Both endpoints are **live and tested** on client environment:

### Products Endpoint
```bash
curl -s -H "x-requestdesk-api-key: YOUR_API_KEY" \
  "https://contentbasis--client.gadget.app/public/products?limit=50"
```

### Collections Endpoint (NEW)
```bash
curl -s -H "x-requestdesk-api-key: YOUR_API_KEY" \
  "https://contentbasis--client.gadget.app/public/collections"
```

---

## 🚨 CRITICAL: Auth Header

**USE:** `x-requestdesk-api-key` (not `x-api-key`)

The Gadget endpoints validate against the `requestDeskAccount` table using this header.

---

## 📋 Response Formats

### Products Response
```json
{
  "success": true,
  "shop": { "id": "...", "domain": "..." },
  "total": 289,
  "pageInfo": { "hasNextPage": true, "endCursor": "..." },
  "products": [
    {
      "id": "...",
      "title": "...",
      "description": "...",
      "handle": "...",
      "url": "https://domain/products/handle",
      "vendor": "...",
      "product_type": "...",
      "tags": [],
      "status": "active",
      "images": [{ "id": "...", "src": "...", "alt": "..." }],
      "variants": [{ "id": "...", "title": "...", "price": "...", "sku": "..." }]
    }
  ]
}
```

### Collections Response
```json
{
  "success": true,
  "shop": { "id": "...", "domain": "..." },
  "total": 46,
  "collections": [
    {
      "id": "...",
      "title": "...",
      "handle": "...",
      "description": "...",
      "collection_type": "smart|custom",
      "image": { "url": "...", "alt": "..." },
      "products_count": 12,
      "published_at": "...",
      "updated_at": "..."
    }
  ]
}
```

---

## 🛑 DO NOT

1. **DO NOT commit to cb-shopify** - Let cb-shopify Claude handle Gadget changes
2. **DO NOT use `x-api-key` header** - Use `x-requestdesk-api-key`
3. **DO NOT call Gadget production** until deployed - Use client environment for now

---

## 📝 RequestDesk Tasks Remaining

Based on previous session, these tasks need implementation in cb-requestdesk:

1. **Update `agent_integration_service.py`:**
   - Ensure collections sync uses correct header
   - Ensure blogs sync uses correct header

2. **Frontend `ShopifyIntegrationPage.tsx`:**
   - Verify sync buttons work with new endpoints

3. **Test end-to-end sync:**
   - Products → RAG documents
   - Collections → RAG documents
   - Blog articles → RAG documents

---

## 🔗 Production Deployment

When ready to go live:
1. Ask user to deploy Gadget client → production via web UI
2. Update RequestDesk to use production URL: `https://contentbasis.gadget.app/public/...`
