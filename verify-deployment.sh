#!/bin/bash

# Vercel Deployment Troubleshooting Script
# Run this to check common issues before deploying

echo "🔍 Vercel Deployment Checklist"
echo "================================"
echo ""

# Check 1: Build locally
echo "✅ Step 1: Testing local build..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Build failed! Fix build errors before deploying."
    exit 1
fi
echo "✅ Build successful!"
echo ""

# Check 2: Check dist directory
echo "✅ Step 2: Checking dist directory..."
if [ ! -d "dist" ]; then
    echo "❌ dist directory not found!"
    exit 1
fi

if [ ! -f "dist/index.html" ]; then
    echo "❌ dist/index.html not found!"
    exit 1
fi
echo "✅ dist directory exists with index.html"
echo ""

# Check 3: Check API files
echo "✅ Step 3: Checking API files..."
if [ ! -d "api" ]; then
    echo "⚠️  api directory not found (optional)"
else
    echo "✅ api directory found"
    ls -la api/
fi
echo ""

# Check 4: Check vercel.json
echo "✅ Step 4: Checking vercel.json..."
if [ ! -f "vercel.json" ]; then
    echo "❌ vercel.json not found!"
    exit 1
fi
echo "✅ vercel.json exists"
cat vercel.json | head -20
echo ""

# Check 5: Check environment variables
echo "✅ Step 5: Environment variables to set in Vercel Dashboard:"
echo "   Go to: Vercel Dashboard > Your Project > Settings > Environment Variables"
echo ""
echo "   Required for Database (optional - app works without it):"
echo "   - DATABASE_URL=<your_neon_or_postgres_url>"
echo ""
echo "   Optional for Image Upload:"
echo "   - IMGBB_API_KEY=<your_imgbb_key>"
echo ""

# Check 6: Preview the build
echo "✅ Step 6: Starting local preview..."
echo "   Opening http://localhost:4173"
echo "   Press Ctrl+C to stop"
echo ""
npm run preview

