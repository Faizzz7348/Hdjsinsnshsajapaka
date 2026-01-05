#!/bin/bash

# 🚀 Quick Deploy to Vercel
# Run this script to deploy your app

echo "🚀 Deploying to Vercel..."
echo ""

# Step 1: Clean and build
echo "📦 Step 1: Building project..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Build failed! Check errors above."
    echo ""
    echo "Common fixes:"
    echo "  - npm install (reinstall dependencies)"
    echo "  - Check for syntax errors in code"
    echo "  - Check for missing imports"
    exit 1
fi

echo "✅ Build successful!"
echo ""

# Step 2: Deploy to Vercel
echo "🌐 Step 2: Deploying to Vercel..."
echo ""

# Check if vercel is installed
if ! command -v vercel &> /dev/null; then
    echo "⚠️  Vercel CLI not installed."
    echo ""
    echo "Install dengan:"
    echo "  npm install -g vercel"
    echo ""
    echo "Atau deploy manual:"
    echo "  1. Push to GitHub"
    echo "  2. Go to https://vercel.com"
    echo "  3. Import your GitHub repo"
    exit 1
fi

# Deploy with vercel
vercel --prod

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📝 Remember to set environment variables di Vercel Dashboard:"
echo "   - VITE_API_URL=/api"
echo "   - DATABASE_URL=<your_db_url> (optional)"
echo ""
