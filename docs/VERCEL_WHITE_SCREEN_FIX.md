# 🚀 Vercel Deployment - Quick Fix Guide

## Masalah: White Screen / Blank Page di Vercel

### Punca-punca Biasa:
1. ❌ Build error tidak nampak
2. ❌ Routing configuration salah  
3. ❌ Environment variables tak set
4. ❌ Base path tidak configure
5. ❌ API routes tak dijumpai

---

## ✅ Penyelesaian (Sudah Dibuat)

### 1. Fix Vite Config
- ✅ Removed invalid `performance` property
- ✅ Added proper `base: '/'` configuration
- ✅ Optimized build settings untuk Vercel

### 2. Fix Vercel.json
- ✅ Added proper `routes` configuration
- ✅ Fixed rewrites untuk SPA routing
- ✅ API routes configured dengan betul

### 3. Created .env.production
- ✅ Added VITE_API_URL=/api untuk client-side

---

## 📋 Steps Untuk Deploy

### A. Test Build Locally Dulu
```bash
# 1. Build project
npm run build

# 2. Preview build (test locally)
npm run preview
```

Browser akan buka `http://localhost:4173` - Check sama ada app berfungsi dengan baik.

### B. Deploy ke Vercel

#### Option 1: Guna Vercel CLI (Recommended)
```bash
# Install Vercel CLI (kalau belum)
npm i -g vercel

# Deploy
vercel --prod
```

#### Option 2: Guna GitHub Integration
1. Push code ke GitHub
2. Go to https://vercel.com
3. Import project dari GitHub
4. Vercel akan auto-deploy

---

## ⚙️ Environment Variables di Vercel

Pergi ke: **Vercel Dashboard → Your Project → Settings → Environment Variables**

### Required untuk Production:
```
Name: VITE_API_URL
Value: /api
Environment: Production, Preview, Development
```

### Optional (kalau guna database):
```
Name: DATABASE_URL
Value: postgresql://user:password@host/db?sslmode=require
Environment: Production, Preview
```

### Optional (kalau guna image upload):
```
Name: IMGBB_API_KEY
Value: your_imgbb_api_key
Environment: Production, Preview
```

**⚠️ PENTING**: 
- Lepas set environment variables, kena **redeploy** project
- Click "Deployments" → Latest Deployment → "..." menu → "Redeploy"

---

## 🔍 Troubleshooting White Screen

### 1. Check Build Logs
```
Vercel Dashboard → Deployments → Latest → View Function Logs
```

### 2. Check Browser Console
```
F12 → Console tab
```
Cari error messages. Common errors:
- ❌ `Failed to fetch` → API routes issue
- ❌ `Cannot read property of undefined` → Missing data
- ❌ `Module not found` → Import path salah

### 3. Check Network Tab
```
F12 → Network tab
```
- Check `/api/routes` dan `/api/locations` requests
- Status 200 = OK
- Status 404 = API route tak jumpa
- Status 500 = Server error

### 4. Run Verification Script
```bash
./verify-deployment.sh
```
Script ini akan:
- Build project locally
- Check semua files ada
- Preview build
- List environment variables needed

---

## 🎯 Common Issues & Solutions

### Issue 1: API Routes Return 404
**Solution:**
- Ensure `api/` folder ada di root (bukan dalam `src/`)
- Check `vercel.json` ada proper routes configuration
- Redeploy after changes

### Issue 2: Environment Variables Tidak Dibaca
**Solution:**
- Pastikan variable name start dengan `VITE_` untuk client-side
- Set di Vercel Dashboard, bukan dalam file `.env`
- Redeploy after setting variables

### Issue 3: Page Loads but Data Tidak Muncul
**Solution:**
- Check Browser Console untuk errors
- Check Network tab untuk API responses
- App akan guna dummy data kalau DATABASE_URL tak set

### Issue 4: Routing Error (404 on Refresh)
**Solution:**
- Ensure `vercel.json` ada proper rewrites
- Check build output di `dist/` folder
- Verify `dist/index.html` exists

---

## 🧪 Test Checklist Before Deploy

- [ ] `npm run build` - Build succeeds tanpa error
- [ ] `npm run preview` - App berfungsi di local preview
- [ ] Browser Console - Tiada error messages
- [ ] Network Tab - API calls berjaya (200 OK)
- [ ] Environment Variables - Set di Vercel Dashboard
- [ ] `vercel.json` - Configuration correct
- [ ] `.vercelignore` - Excludes test files

---

## 📞 Quick Commands

```bash
# Build locally
npm run build

# Preview build
npm run preview

# Deploy to Vercel
vercel --prod

# Check Vercel logs
vercel logs

# Run verification
./verify-deployment.sh
```

---

## 🎉 Expected Results

Selepas deployment successful:

1. ✅ App loads tanpa white screen
2. ✅ Data appears (dummy data kalau no DATABASE_URL)
3. ✅ No console errors
4. ✅ API routes working (check Network tab)
5. ✅ Routing works (refresh page masih shows content)

---

## 💡 Pro Tips

1. **Always test build locally first** dengan `npm run build && npm run preview`
2. **Check browser console** - Most errors visible here
3. **Use Vercel CLI** untuk faster deployments
4. **Set environment variables** sebelum deploy
5. **App works without database** - guna dummy data for testing

---

## 📚 Additional Resources

- [Vite Deployment Guide](https://vitejs.dev/guide/static-deploy.html)
- [Vercel Documentation](https://vercel.com/docs)
- [Vercel Serverless Functions](https://vercel.com/docs/functions)

---

## 🆘 Still White Screen?

Run this command dan screenshot the output:
```bash
npm run build && npm run preview
```

Then check:
1. Does it work locally? 
   - Yes → Environment variables issue di Vercel
   - No → Build error, check error messages

2. Browser Console errors?
   - Share error message

3. Vercel deployment logs?
   - Dashboard → Deployments → Latest → View Logs
   - Share error messages

---

**Note**: App direka untuk berfungsi tanpa database. Kalau DATABASE_URL tak set, app akan guna dummy data automatically. Jadi tiada sebab untuk white screen! 🎉
