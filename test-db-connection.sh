#!/bin/bash

echo "🔍 Testing Database Connection..."
echo "=================================="
echo ""

# Create a test script
cat > /tmp/test-db.mjs << 'EOF'
import { neon } from '@neondatabase/serverless';

const DATABASE_URL = process.env.DATABASE_URL;

if (!DATABASE_URL) {
  console.error('❌ DATABASE_URL not set');
  process.exit(1);
}

console.log('📍 Testing connection to Neon database...');
console.log('');

const sql = neon(DATABASE_URL);

try {
  // Test simple query
  const result = await sql`SELECT NOW() as current_time, version() as pg_version`;
  
  console.log('✅ DATABASE CONNECTION SUCCESSFUL!');
  console.log('');
  console.log('Connection Details:');
  console.log('  • Time:', result[0].current_time);
  console.log('  • PostgreSQL Version:', result[0].pg_version.split(' ')[0] + ' ' + result[0].pg_version.split(' ')[1]);
  console.log('');
  
  // Check if tables exist
  const tables = await sql`
    SELECT tablename 
    FROM pg_tables 
    WHERE schemaname = 'public'
    ORDER BY tablename
  `;
  
  if (tables.length > 0) {
    console.log('📊 Existing Tables:');
    tables.forEach(t => console.log('  • ' + t.tablename));
  } else {
    console.log('⚠️  No tables found in database');
    console.log('💡 You need to create tables first');
  }
  
  console.log('');
  console.log('🎉 Database is ready to use!');
  process.exit(0);
  
} catch (error) {
  console.error('❌ DATABASE CONNECTION FAILED!');
  console.error('');
  console.error('Error:', error.message);
  console.error('');
  console.error('Possible issues:');
  console.error('  • DATABASE_URL incorrect');
  console.error('  • Network/firewall blocking connection');
  console.error('  • Database server not running');
  console.error('');
  process.exit(1);
}
EOF

# Load .env and run test
export $(cat .env | grep -v '^#' | xargs)
node /tmp/test-db.mjs

# Cleanup
rm /tmp/test-db.mjs
