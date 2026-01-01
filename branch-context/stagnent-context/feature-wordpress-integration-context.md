# Branch Context: feature/wordpress-integration

**Saved:** 2025-09-08 00:30 UTC via /claude-close
**Last Commit:** 8525577e - complete: Archive ticket comment images fix - branch completion
**Security Status:** 95/100 (0 critical issues, minor warnings in demo files)

## Work Completed ✅
- Fixed WordPress sync Docker networking issues (Local by Flywheel compatibility)
- Forced SentenceTransformer to work fully offline (no HuggingFace API calls)
- Optimized embedding generation (load model once, not per chunk)
- Successfully synced 671 WordPress posts with embeddings
- **CRITICAL FIX:** Identified and documented RAG source_type discrimination bug
- Changed WordPress chunks from `source_type: "wordpress"` to `"documentation"` as workaround

## Work In Progress 🔄
- RAG search still has fundamental issues with WordPress content discovery
- The source_type discrimination bug needs proper fix in RAG service
- Testing with generic queries (TikTok) gives false positives

## Critical Findings 🚨
1. **RAG discriminates against source_type: "wordpress"**
   - Identical chunks with different source_types behave differently
   - Only "documentation", "user_input" source_types are searchable
   - Workaround: Changed all WordPress chunks to use "documentation"

2. **False positive testing issue**
   - Generic queries like "TikTok marketing" return LLM-generated content
   - Makes it appear RAG is working when it's not
   - Must test with unique phrases LLM wouldn't know

## Files Modified
- `/backend/app/services/wordpress_content_service.py` - Added offline embedding generation
- `/backend/app/services/rag_ingestion.py` - Forced offline mode for SentenceTransformer
- Multiple documentation files created in `/documentation/docs/technical/`
- **VIOLATION:** Created test files in root (user deleted them)

## Security Findings
- ✅ No critical security issues
- ✅ Offline embedding eliminates API key risks
- ⚠️ Created files in wrong locations (root directory)

## Next Steps
1. **Fix RAG source_type discrimination** - Find and fix the code that filters by source_type
2. **Test with unique content** - Stop using generic queries that give false positives
3. **Update WordPress sync** - Make it use "documentation" source_type permanently
4. **Clean up test approach** - Use proper test directories

## Documentation & Work Directory
**📁 TODO Directory**: `/todo/current/feature/wordpress-integration/` (if exists)
**📚 Technical Docs**: `/documentation/docs/technical/wordpress-rag-*.md`
**🔒 Violation Log**: `.claude/incorrect-instruction-log.md` (Violation #49 added)

## Recovery Instructions
To resume work on this branch:
```bash
git checkout feature/wordpress-integration
/claude-start
```

## Key Issues to Remember
1. **WordPress chunks with source_type: "wordpress" are NOT searchable**
2. **Workaround applied: Changed to source_type: "documentation"**
3. **Don't test with generic queries - use unique content**
4. **The real bug is in the RAG search algorithm, not the data**

## Status
**BLOCKED** - RAG source_type discrimination bug prevents proper WordPress integration. Workaround applied but root cause needs fixing.
