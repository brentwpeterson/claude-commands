# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `main`
3. **Load brand persona:** Run `/brand-brent` before generating content

## SESSION SUMMARY
**Task:** HubSpot Relationship Tier Auto-Assignment - IN PROGRESS

## WHAT WE DID THIS SESSION

### Batch Updated First 100 Contacts with relationship_tier

From `/tmp/batch1.txt` and `/tmp/primary_contacts.txt`:

| Tier | Count | Criteria |
|------|-------|----------|
| Tier 1 | 1 | Already assigned (Chase - 1332451 with 135 notes) |
| Tier 3 | 50 | 10-49 notes (Known Of) |
| Tier 4 | 45 | 1-9 notes (Researched) |
| Tier 5 | 4 | 0 notes (Cold) |
| **Total** | **100** | First batch processed |

### Tier 2 Contacts (50+ notes) - Previously Updated
- idrees@rltsquare.com (69173969750): 92 notes → Tier 2
- anya@taelor.ai (100533822876): 51 notes → Tier 2

## PENDING WORK

### Remaining Contacts to Process
- **Total PRIMARY_IDS:** 332 contacts
- **Processed:** ~100 contacts
- **Remaining:** ~232 contacts need tier assignment

### Reference Files
- `/tmp/hubspot_ids.py` - Contains full PRIMARY_IDS and NON_PRIMARY_IDS lists
- Plan file: `/Users/brent/.claude/plans/cryptic-questing-finch.md`

### Tiering Algorithm (from approved plan)
```
Tier 1: Manual approval only (Inner Circle) - requires note scanning
Tier 2: num_notes >= 50 (Warm Connection)
Tier 3: num_notes >= 10 (Known Of)
Tier 4: num_notes >= 1 (Researched)
Tier 5: num_notes = 0 (Cold)
```

## TODO LIST STATE
- ✅ Query all 368 Shopify contacts with activity properties
- 🔄 Apply tiering rules and batch update relationship_tier (~30% done)
- ⏳ Identify high-engagement contacts for Tier 1 scanning
- ⏳ Scan notes for relationship keywords
- ⏳ Output Tier 1 candidate list for approval

## NEXT ACTIONS
1. **FIRST:** Query remaining contacts from PRIMARY_IDS (use HubSpot batch-read or search)
2. **THEN:** Parse num_notes and batch update with appropriate tier
3. **THEN:** Identify Tier 1 candidates (num_notes >= 20) for note scanning

## VERIFICATION COMMANDS
```bash
# Check PRIMARY_IDS count
python3 /tmp/hubspot_ids.py

# View plan
cat /Users/brent/.claude/plans/cryptic-questing-finch.md
```

## CONTEXT NOTES
- HubSpot MCP tools used for batch updates (max 100 per batch)
- relationship_tier property already created (enumeration 1-5)
- primary_company_contact property identifies which contacts receive emails
- Previous session context: `.claude/branch-context/bw-hubspot-enrichment-batch-context.md`

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Task status:** "Continue with remaining ~232 contacts for tier assignment?"
