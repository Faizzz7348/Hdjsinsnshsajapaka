#!/bin/bash

echo "🚀 Running Git Commit..."
echo "========================"
echo ""

cd /workspaces/Hdjsinsnshsajapaka

# Clean up duplicate/temp files first
rm -f "h check-commit.sh" 2>/dev/null
rm -f "h origin main" 2>/dev/null

echo "📝 Staging all changes..."
git add -A

echo "💾 Creating commit..."
git commit -m "refactor: major cleanup and optimization

🗑️ Removed Prisma ORM:
- Removed @prisma/client and prisma packages
- Removed prisma/ folder (schema, migrations)
- Updated vercel.json build command
- App uses raw SQL with @neondatabase/serverless

🖼️ Switched to ImgBB:
- Replaced Vercel Blob with ImgBB API
- Removed @vercel/blob package
- Rewrote api/upload.js for ImgBB
- Free unlimited image hosting

🧹 Cleanup:
- Deleted 15+ obsolete scripts
- Deleted 11 duplicate docs
- Organized documentation
- Clean project structure

✅ Database:
- Connected to Neon PostgreSQL
- Verified Route & Location tables
- Test script created

📝 Status: Production Ready"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ COMMIT BERJAYA!"
    echo ""
    echo "📊 Commit details:"
    git log -1 --oneline
    echo ""
    echo "🚀 Next: git push origin main"
else
    echo ""
    echo "❌ Commit failed. Check errors above."
fi
