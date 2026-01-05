#!/bin/bash

echo "🔍 Checking Git Status..."
echo "========================="
echo ""

cd /workspaces/Hdjsinsnshsajapaka

# Check if there are uncommitted changes
if git status --short | grep -q .; then
    echo "❌ COMMIT BELUM BERJAYA"
    echo ""
    echo "📝 Files yang belum commit:"
    git status --short
    echo ""
    echo "💡 Run: bash commit-changes.sh"
else
    echo "✅ COMMIT BERJAYA!"
    echo ""
    echo "📊 Last commit:"
    git log -1 --oneline
    echo ""
    echo "🚀 Ready to push!"
    echo "   Run: git push origin main"
fi

echo ""
