# Shopify App Management

Skill for managing the RequestDesk Content Builder Shopify app built on Gadget.

## App Configuration

### Two Environments

| Environment | App Name | Client ID | URL |
|-------------|----------|-----------|-----|
| **Production** | RequestDesk Content Builder | `037394b1e98d35edfce74114b2f16148` | `https://contentbasis.gadget.app` |
| **Development** | RequestDesk Content Builder (Dev) | `55d84bce9343999eab6423a3c94a190f` | `https://contentbasis--client.gadget.app` |

### Key URLs

| Purpose | URL |
|---------|-----|
| Gadget Editor (Production) | https://contentbasis.gadget.app/edit/production |
| Gadget Editor (Client/Dev) | https://contentbasis.gadget.app/edit/client |
| Shopify Connection Settings | https://contentbasis.gadget.app/edit/production/settings/connections/shopify |
| View Installs | Gadget Editor → Data → Installs (left sidebar) |

---

## Installing on a New Store

### Why Direct OAuth Links Don't Work

For Gadget apps with "Managed installs", direct OAuth URLs like:
```
https://admin.shopify.com/store/STORE-NAME/oauth/install?client_id=CLIENT_ID
```
Will return: **"The installation link for this app is invalid"**

This is because the app isn't configured for public distribution. You must add stores through Gadget or Shopify Partners.

### Method 1: Via Shopify Partners (Recommended)

1. Go to: https://partners.shopify.com
2. Find **"RequestDesk Content Builder"** app in your apps list
3. Click on the app → **Test your app** or **Distribution**
4. Click **"Select store"** or **"Add development store"**
5. Enter the store name (e.g., `industrial-farm-co`)
6. Complete the OAuth authorization flow
7. The store will now appear in Gadget's Installs list

### Method 2: Via Gadget Dashboard

1. Go to: https://contentbasis.gadget.app/edit/production
2. Click **Settings** (gear icon in left sidebar)
3. Click **Plugins** → Find **Shopify connection**
4. In "Connected apps" section, click **"Installs (N)"**
5. Look for an **"Add"** button or **"+"** icon
6. If available, enter the store's myshopify.com URL

**Note:** The "Add" option may not be visible in production. Use Shopify Partners method if not available.

### Method 3: Development Store Installation

For development/testing on the **client** environment:

1. Go to: https://contentbasis.gadget.app/edit/client/settings/connections/shopify
2. The client environment may have more flexible installation options
3. Use client ID: `55d84bce9343999eab6423a3c94a190f`

---

## Viewing Current Installs

1. Go to Gadget Editor: https://contentbasis.gadget.app/edit/production
2. Click **"Installs"** in the left sidebar (under Data section)
3. Or: Settings → Plugins → Shopify → "Installs (N)" link

### Install Data Columns

| Column | Description |
|--------|-------------|
| Shop URL | The myshopify.com domain |
| API Scope Access | Green = all scopes granted, Yellow = missing scopes |
| Webhook Status | Whether webhooks are registered |
| Last Sync | When data was last synced from Shopify |

---

## Managing Existing Installs

### Triggering a Sync

1. Go to Installs list in Gadget
2. Find the store row
3. Click **"Sync"** button on the right

### Checking Missing Scopes

If you see "1 missing scope..." warning:
1. Click on the store row to see details
2. Note which scope is missing
3. The merchant may need to re-authorize the app to grant new scopes

### Removing an Install

1. Go to Installs in Gadget Data section
2. Click on the store
3. Look for delete/remove option
4. **Warning:** This will disconnect the app from that store

---

## Troubleshooting

### "Installation link is invalid"

**Cause:** App is set to "Managed installs" and requires adding stores through Gadget/Partners.

**Solution:** Use Shopify Partners to add the store as a test store first.

### Store not appearing after install

1. Check Gadget Logs for errors
2. Verify the OAuth flow completed successfully
3. Try clicking "Sync" if the store appears but has no data

### Missing scopes after install

1. Go to Settings → Plugins → Shopify connection
2. Click "Edit" to see required scopes
3. Have the merchant re-authorize via the app in their Shopify admin

---

## Related Files

| File | Purpose |
|------|---------|
| `cb-shopify/shopify.app.toml` | Production app configuration |
| `cb-shopify/shopify.app.development.toml` | Development app configuration |
| `cb-shopify/DEPLOYMENT.md` | Deployment documentation |
| `cb-shopify/CLAUDE.md` | Full project documentation |

---

## Quick Reference

**Add new store:**
1. Shopify Partners → App → Test your app → Select store

**View installs:**
1. Gadget → Data → Installs

**Sync store data:**
1. Gadget → Installs → Find store → Click "Sync"

**Check logs:**
1. Gadget → Logs (left sidebar)
