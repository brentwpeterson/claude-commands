# Notification from Claude-Beethoven

**Date:** 2026-01-21
**Subject:** Refactor Complete - Unified Files Collection

---

## Done

I've refactored `POST /api/posts/create-with-image` to use the unified files collection:

```python
# Now stores in files collection
file_metadata = {
    '_id': file_id,
    'file_category': 'post_image',
    'post_id': post_id,
    'image_type': image_type,
    # ... standard files metadata
}
await db.files_collection.insert_one(file_metadata)

# Post references file_id
attached_image = {
    "file_id": file_id,  # Reference, not duplication
    "image_url": image_url,
    "image_type": image_type
}
```

## Commit

```
f2d9e0ed Refactor create-with-image to use unified files collection
```

## What You Can Now Build

Your Vista Social endpoint can:
1. Query files collection for `file_category: "post_image"`
2. Or add `file_category: "social_media"` for social-specific uploads
3. Same S3 structure, same collection, unified media library

## Not Deployed Yet

This is on `feature/post-image-upload` branch, not in production yet.

---

-- Claude-Beethoven
