# Deploy Documentation - Production Deployment Command

**Purpose**: Deploy documentation container to AWS ECS production environment  
**Trigger**: `docs-v*` tag pattern  
**Deployment Time**: ~10-15 minutes  

## Command Usage
```bash
/deploy-documentation [reason]
```

**Examples:**
- `/deploy-documentation` (uses default reason: "documentation-update")
- `/deploy-documentation new-guides` 
- `/deploy-documentation root-cleanup-test`
- `/deploy-documentation api-docs-update`

## What This Command Does

### 1. Version Management
- Reads current version from `/VERSION` file
- Uses current version (does NOT increment)
- Creates tag format: `docs-v[CURRENT_VERSION]-[REASON]`

### 2. GitHub Actions Deployment
- Triggers `aws-deploy-documentation.yml` workflow
- Builds documentation container from `/documentation/Dockerfile`
- Uses task definition: `docker/documentation-task-definition.json`
- Deploys to ECS service: `cb-app-documentation-service`

### 3. Deployment Process
```bash
# 1. Read current version
CURRENT_VERSION=$(cat VERSION)

# 2. Create deployment tag
git tag docs-v$CURRENT_VERSION-$REASON

# 3. Push to trigger deployment
git push origin docs-v$CURRENT_VERSION-$REASON

# 4. Show GitHub Actions URL for monitoring
echo "Documentation deployment initiated!"
echo "Monitor: https://github.com/brentwpeterson/cb-app/actions"
```

## Documentation Deployment Details

**Container**: `cb-app-documentation`  
**Service**: `cb-app-documentation-service`  
**Cluster**: `cb-app-cluster`  
**ECR Repository**: `cb-app-documentation`  
**Task Definition**: `docker/documentation-task-definition.json`

## Tag Patterns Supported
The documentation workflow responds to these tag patterns:
- `docs-v*` ← **Primary pattern used by this command**
- `docs-poc-v*`
- `documentation-v*` 
- `release-v*`

## Testing After Deployment
After deployment completes, verify documentation is accessible:
- Check ECS service status in AWS Console
- Verify documentation site loads correctly
- Test that updated content is visible

## Integration with Root Directory Cleanup
This command was created during the root directory reorganization project to test that moved AWS task definition files work correctly. The documentation deployment specifically tests:
- `docker/documentation-task-definition.json` (moved from root)
- GitHub Actions workflow can find task definition at new location
- ECS deployment process works with reorganized file structure

## Related Commands
- `/deploy-code` - Deploy main application (frontend + backend)
- See `/documentation/docs/technical/deployment/DEPLOYMENT-TAGS.md` for all deployment patterns

## Workflow File
This command triggers: `.github/workflows/aws-deploy-documentation.yml`