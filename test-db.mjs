import { neon } from '@neondatabase/serverless';
import 'dotenv/config';

const DATABASE_URL = process.env.DATABASE_URL;

console.log('🔍 Testing Neon Database Connection...');
console.log('==========================================\n');

if (!DATABASE_URL) {
  console.error('❌ DATABASE_URL not found in .env file');
  process.exit(1);
}

console.log('📍 Database Host:', DATABASE_URL.split('@')[1]?.split('/')[0] || 'Unknown');
console.log('📦 Database Name:', DATABASE_URL.split('/').pop()?.split('?')[0] || 'Unknown');
console.log('');

const sql = neon(DATABASE_URL);

try {
  console.log('⏳ Connecting to database...\n');
  
  // Test 1: Basic connection
  const result = await sql`SELECT NOW() as current_time, version() as pg_version`;
  
  console.log('✅ CONNECTION SUCCESSFUL!\n');
  console.log('Connection Details:');
  console.log('  • Server Time:', result[0].current_time);
  console.log('  • PostgreSQL:', result[0].pg_version.substring(0, 50) + '...');
  console.log('');
  
  // Test 2: Check existing tables
  const tables = await sql`
    SELECT tablename 
    FROM pg_tables 
    WHERE schemaname = 'public'
    ORDER BY tablename
  `;
  
  console.log('📊 Database Tables:');
  if (tables.length > 0) {
    tables.forEach(t => console.log('  ✓ ' + t.tablename));
    console.log('');
    
    // Test 3: Count records in each table
    console.log('📈 Table Record Counts:');
    for (const table of tables) {
      try {
        // Use raw identifier for table name
        const tableName = table.tablename;
        const count = await sql(`SELECT COUNT(*) as count FROM "${tableName}"`);
        console.log(`  • ${tableName}: ${count[0].count} records`);
      } catch (err) {
        console.log(`  • ${table.tablename}: Error counting records`);
      }
    }
  } else {
    console.log('  ⚠️  No tables found');
    console.log('  💡 Tables will be created when app runs for first time');
  }
  
  console.log('');
  console.log('🎉 DATABASE IS READY!');
  console.log('');
  console.log('Next steps:');
  console.log('  • Run: npm run dev');
  console.log('  • App will connect to database automatically');
  console.log('  • If no tables, dummy data will be used initially');
  console.log('');
  
} catch (error) {
  console.error('❌ CONNECTION FAILED!\n');
  console.error('Error:', error.message);
  console.error('');
  console.error('Troubleshooting:');
  console.error('  1. Check DATABASE_URL is correct in .env');
  console.error('  2. Verify network connection');
  console.error('  3. Check Neon database is active');
  console.error('  4. Try removing "?sslmode=require" from URL');
  console.error('');
  process.exit(1);
}
