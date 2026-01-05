#!/bin/bash

echo "🗑️  Cleaning Up Unnecessary Shell Scripts..."
echo "=============================================="
echo ""

# OBSOLETE - Already executed (Prisma removal done)
echo "Deleting: remove-prisma.sh (already executed)"
rm -f remove-prisma.sh

# OBSOLETE - Prisma related
echo "Deleting: setup-neon.sh (Prisma setup, not needed)"
rm -f setup-neon.sh

# REDUNDANT - Old commit scripts (use deploy.sh instead)
echo "Deleting: commit.sh (use deploy.sh)"
rm -f commit.sh

echo "Deleting: commit-fixes.sh (use deploy.sh)"
rm -f commit-fixes.sh

echo "Deleting: commit-optimization.sh (use deploy.sh)"
rm -f commit-optimization.sh

# REDUNDANT - Multiple deploy scripts (keep deploy.sh only)
echo "Deleting: DEPLOY_NOW.sh (use deploy.sh)"
rm -f DEPLOY_NOW.sh

echo "Deleting: REDEPLOY.sh (use deploy.sh)"
rm -f REDEPLOY.sh

echo "Deleting: quick-deploy.sh (use deploy.sh)"
rm -f quick-deploy.sh

# REDUNDANT - Temporary fix scripts
echo "Deleting: quick-fix-blank.sh (already fixed)"
rm -f quick-fix-blank.sh

echo "Deleting: move-files.sh (temporary, not needed)"
rm -f move-files.sh

# REDUNDANT - Diagnostic (can use npm commands instead)
echo "Deleting: diagnose-vercel.sh (use npm run build to check)"
rm -f diagnose-vercel.sh

echo "Deleting: build-optimized.sh (use npm run build)"
rm -f build-optimized.sh

# OPTIONAL - Documentation scripts (keep if useful, delete if not)
echo "Deleting: VITE_API_URL_QUICK_REF.sh (static documentation better)"
rm -f VITE_API_URL_QUICK_REF.sh

echo "Deleting: VITE_API_URL_VISUAL_GUIDE.sh (static documentation better)"
rm -f VITE_API_URL_VISUAL_GUIDE.sh

echo "Deleting: cleanup-docs.sh (one-time use, done)"
rm -f cleanup-docs.sh

echo ""
echo "✅ Cleanup Complete!"
echo ""
echo "📋 Scripts KEPT (useful):"
echo "   ✅ deploy.sh - Universal deployment script"
echo "   ✅ clear-cache.sh - Clear build cache when needed"
echo ""
echo "📋 Scripts DELETED:"
echo "   ❌ remove-prisma.sh (already executed)"
echo "   ❌ setup-neon.sh (Prisma related)"
echo "   ❌ commit*.sh (3 files - use deploy.sh)"
echo "   ❌ DEPLOY_NOW.sh, REDEPLOY.sh, quick-deploy.sh (use deploy.sh)"
echo "   ❌ quick-fix-blank.sh (temporary fix)"
echo "   ❌ move-files.sh (temporary)"
echo "   ❌ diagnose-vercel.sh (use npm commands)"
echo "   ❌ build-optimized.sh (use npm run build)"
echo "   ❌ VITE_API_URL_*.sh (2 files - static docs better)"
echo "   ❌ cleanup-docs.sh (one-time use)"
echo ""
echo "Total deleted: 15 scripts"
echo "Total kept: 2 scripts (deploy.sh, clear-cache.sh)"
echo ""
echo "🎯 Now you have a clean, minimal setup!"
