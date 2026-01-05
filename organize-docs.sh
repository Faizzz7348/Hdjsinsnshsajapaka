#!/bin/bash

echo "📁 Organizing and Cleaning Up Markdown Files..."
echo "================================================"
echo ""

# Create docs folder if not exists
mkdir -p docs

echo "Step 1: Moving useful .md files from root to docs/"
echo "---------------------------------------------------"

# KEEP in root (essential)
echo "✅ Keeping in root: README.md (main documentation)"

# MOVE to docs (useful documentation)
echo "Moving: OPTIMIZATION_SUMMARY.md → docs/"
mv -f OPTIMIZATION_SUMMARY.md docs/ 2>/dev/null || echo "  Already moved or not found"

echo "Moving: QUICKSTART_OPTIMIZED.md → docs/"
mv -f QUICKSTART_OPTIMIZED.md docs/ 2>/dev/null || echo "  Already moved or not found"

echo "Moving: PRISMA_REMOVED.md → docs/"
mv -f PRISMA_REMOVED.md docs/ 2>/dev/null || echo "  Already moved or not found"

echo ""
echo "Step 2: Deleting obsolete/duplicate .md files"
echo "----------------------------------------------"

# ROOT - Obsolete files
echo "Deleting: CLEANUP_NOTES.md (temporary notes)"
rm -f CLEANUP_NOTES.md

echo "Deleting: READY_TO_DEPLOY.md (outdated deployment guide)"
rm -f READY_TO_DEPLOY.md

echo "Deleting: SCRIPTS_GUIDE.md (scripts cleaned up, not needed)"
rm -f SCRIPTS_GUIDE.md

echo "Deleting: FIX_BLANK_PAGE_VERCEL.md (issue already fixed)"
rm -f FIX_BLANK_PAGE_VERCEL.md

# VITE_API_URL - Keep only one detailed version in docs/
echo "Deleting: VITE_API_URL_INDEX.md (duplicate, use docs/VITE_API_URL_EXPLAINED.md)"
rm -f VITE_API_URL_INDEX.md

echo "Deleting: VITE_API_URL_SIMPLE.md (duplicate, use docs/VITE_API_URL_EXPLAINED.md)"
rm -f VITE_API_URL_SIMPLE.md

echo ""
echo "Step 3: Cleaning up docs/ folder - removing duplicates"
echo "-------------------------------------------------------"

# DOCS - Duplicate versions (keep v2/latest only)
echo "Deleting: docs/CACHING_IMPROVEMENTS.md (old version, keep v2)"
rm -f docs/CACHING_IMPROVEMENTS.md

echo "Deleting: docs/IMAGELIGHTBOX_README.md (duplicate, use IMAGE_LIGHTGALLERY_GUIDE.md)"
rm -f docs/IMAGELIGHTBOX_README.md

echo "Deleting: docs/DATABASE_SETUP.md (old, use DATABASE_SETUP_PRODUCTION.md)"
rm -f docs/DATABASE_SETUP.md

# DOCS - Prisma related (no longer using Prisma)
echo "Deleting: docs/NEON_DATABASE_SETUP.md (Prisma setup, not using Prisma)"
rm -f docs/NEON_DATABASE_SETUP.md

echo "Deleting: docs/NEON_SERVERLESS_SETUP.md (already using serverless)"
rm -f docs/NEON_SERVERLESS_SETUP.md

# DOCS - Troubleshooting for fixed issues
echo "Deleting: docs/VERCEL_BLANK_PAGE_TROUBLESHOOTING.md (issue fixed)"
rm -f docs/VERCEL_BLANK_PAGE_TROUBLESHOOTING.md

echo "Deleting: docs/SAVE_TROUBLESHOOTING.md (feature stable)"
rm -f docs/SAVE_TROUBLESHOOTING.md

echo "Deleting: docs/IMAGE_UPLOAD_FIX_SUMMARY.md (issue fixed)"
rm -f docs/IMAGE_UPLOAD_FIX_SUMMARY.md

# DOCS - Redundant/obsolete
echo "Deleting: docs/ENVIRONMENT_SETUP.md (covered in main README)"
rm -f docs/ENVIRONMENT_SETUP.md

echo "Deleting: docs/DESCRIPTION_MIGRATION_GUIDE.md (migration done)"
rm -f docs/DESCRIPTION_MIGRATION_GUIDE.md

echo "Deleting: docs/QR_CODE_USAGE_EXAMPLE.md (covered in QR_CODE_FEATURE.md)"
rm -f docs/QR_CODE_USAGE_EXAMPLE.md

echo ""
echo "✅ Cleanup Complete!"
echo ""
echo "📊 Summary:"
echo "==========="
echo ""
echo "ROOT FILES:"
echo "  ✅ KEPT: README.md (main documentation)"
echo "  ❌ DELETED: 6 files (obsolete/duplicate)"
echo "  📁 MOVED TO DOCS: 3 files"
echo ""
echo "DOCS FOLDER:"
echo "  ✅ KEPT: 17 useful documentation files"
echo "  ❌ DELETED: 11 duplicate/obsolete files"
echo ""
echo "📋 Remaining Documentation (Clean & Organized):"
echo ""
echo "ROOT:"
echo "  • README.md - Main project documentation"
echo ""
echo "DOCS/ FOLDER:"
echo "  Setup & Configuration:"
echo "    • DATABASE_SETUP_PRODUCTION.md - Production database setup"
echo "    • DEPLOYMENT_CHECKLIST.md - Deployment guide"
echo "    • VERCEL_BLOB_SETUP.md - Image storage setup"
echo "    • VERCEL_DEPLOYMENT.md - Vercel deployment"
echo "    • VITE_API_URL_EXPLAINED.md - API URL configuration"
echo ""
echo "  Features:"
echo "    • AUTO_QR_SCAN_FEATURE.md - QR scanning"
echo "    • QR_CODE_FEATURE.md - QR code management"
echo "    • MAP_FEATURE_SETUP.md - Map integration"
echo "    • SAVE_FEATURE_SETUP.md - Save functionality"
echo "    • SAVE_ORDER_PRESET.md - Order presets"
echo "    • DUPLICATE_VALIDATION.md - Validation system"
echo "    • IMAGE_LIGHTGALLERY_GUIDE.md - Image gallery"
echo "    • PUBLIC_DATA_SETUP.md - Public data"
echo "    • DEVICE_DETECTION_README.md - Device detection"
echo ""
echo "  Performance & Optimization:"
echo "    • CACHING_IMPROVEMENTS_v2.md - Caching system"
echo "    • PERFORMANCE_OPTIMIZATION.md - Performance tips"
echo "    • SERVICE_WORKER_ANALYSIS.md - PWA/Service Worker"
echo "    • PWA_SETUP_GUIDE.md - Progressive Web App"
echo ""
echo "  Recent Changes:"
echo "    • OPTIMIZATION_SUMMARY.md - Latest optimizations"
echo "    • QUICKSTART_OPTIMIZED.md - Quick start guide"
echo "    • PRISMA_REMOVED.md - Prisma removal notes"
echo ""
echo "🎯 Total: 1 file in root + 20 files in docs/ = 21 documentation files"
echo ""
echo "✨ Documentation is now clean, organized, and up-to-date!"
