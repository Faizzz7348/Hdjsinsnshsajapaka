import formidable from 'formidable';
import fs from 'fs/promises';

// Config for Vercel serverless function
export const config = {
  api: {
    bodyParser: false,
    externalResolver: true,
  },
  maxDuration: 10,
};

// Helper function to parse form data
const parseForm = (req) => {
  return new Promise((resolve, reject) => {
    const form = formidable({
      maxFileSize: 10 * 1024 * 1024, // 10MB limit
      keepExtensions: true,
      multiples: false,
      allowEmptyFiles: false,
      minFileSize: 1,
      uploadDir: '/tmp',
      filename: (name, ext, part, form) => {
        return `upload_${Date.now()}${ext}`;
      },
      hashAlgorithm: false
    });

    form.parse(req, (err, fields, files) => {
      if (err) {
        console.error('Formidable parse error:', err);
        reject(err);
      } else {
        console.log('Form parsed successfully');
        resolve({ fields, files });
      }
    });
  });
};

// Upload to ImgBB
const uploadToImgBB = async (filepath) => {
  try {
    // Read file as base64
    const fileBuffer = await fs.readFile(filepath);
    const base64Image = fileBuffer.toString('base64');
    
    // ImgBB API endpoint
    const apiKey = process.env.IMGBB_API_KEY;
    
    if (!apiKey) {
      throw new Error('IMGBB_API_KEY not configured');
    }
    
    // Create form data for ImgBB
    const formData = new URLSearchParams();
    formData.append('key', apiKey);
    formData.append('image', base64Image);
    
    // Upload to ImgBB
    const response = await fetch('https://api.imgbb.com/1/upload', {
      method: 'POST',
      body: formData,
    });
    
    const result = await response.json();
    
    if (!response.ok || !result.success) {
      throw new Error(result.error?.message || 'ImgBB upload failed');
    }
    
    return {
      url: result.data.url,
      displayUrl: result.data.display_url,
      deleteUrl: result.data.delete_url,
      thumbnailUrl: result.data.thumb.url,
      mediumUrl: result.data.medium?.url || result.data.url,
    };
  } catch (error) {
    console.error('ImgBB upload error:', error);
    throw error;
  }
};

export default async function handler(req, res) {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  // GET - Return status
  if (req.method === 'GET') {
    const hasApiKey = !!process.env.IMGBB_API_KEY;
    return res.status(200).json({
      status: 'ok',
      service: 'ImgBB',
      configured: hasApiKey,
      message: hasApiKey 
        ? 'ImgBB image upload is ready' 
        : 'ImgBB API key not configured',
    });
  }

  // Only POST allowed for upload
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    console.log('Starting ImgBB upload process...');
    
    // Check API key
    if (!process.env.IMGBB_API_KEY) {
      return res.status(500).json({ 
        error: 'ImgBB API key not configured',
        message: 'Please set IMGBB_API_KEY in environment variables'
      });
    }
    
    // Parse the multipart form data
    const { fields, files } = await parseForm(req);
    
    // Get the uploaded file - handle different formidable versions
    let file = null;
    
    if (files.image) {
      file = Array.isArray(files.image) ? files.image[0] : files.image;
    } else if (files.file) {
      file = Array.isArray(files.file) ? files.file[0] : files.file;
    } else {
      const firstKey = Object.keys(files)[0];
      if (firstKey) {
        file = Array.isArray(files[firstKey]) ? files[firstKey][0] : files[firstKey];
      }
    }
    
    if (!file) {
      console.error('No file found in request');
      return res.status(400).json({ 
        error: 'No file uploaded',
        message: 'Please select an image file to upload'
      });
    }
    
    console.log('File details:', {
      name: file.originalFilename || file.name,
      size: file.size,
      type: file.mimetype || file.type,
      path: file.filepath || file.path
    });
    
    // Validate file type
    const mimeType = file.mimetype || file.type || '';
    if (!mimeType.startsWith('image/')) {
      return res.status(400).json({ 
        error: 'Invalid file type. Only images are allowed.',
        type: mimeType
      });
    }
    
    // Validate file size (10MB max)
    if (file.size > 10 * 1024 * 1024) {
      return res.status(400).json({ 
        error: 'File too large. Maximum size is 10MB.',
        size: file.size
      });
    }
    
    // Get file path
    const filepath = file.filepath || file.path;
    
    if (!filepath) {
      return res.status(500).json({ error: 'File path not found' });
    }
    
    console.log('Uploading to ImgBB...');
    
    // Upload to ImgBB
    const uploadResult = await uploadToImgBB(filepath);
    
    console.log('Upload successful:', uploadResult.url);
    
    // Clean up temp file
    try {
      await fs.unlink(filepath);
      console.log('Temp file cleaned up');
    } catch (cleanupError) {
      console.warn('Failed to clean up temp file:', cleanupError);
    }
    
    // Return success response
    return res.status(200).json({
      success: true,
      url: uploadResult.url,
      displayUrl: uploadResult.displayUrl,
      thumbnailUrl: uploadResult.thumbnailUrl,
      mediumUrl: uploadResult.mediumUrl,
      deleteUrl: uploadResult.deleteUrl,
      message: 'Image uploaded successfully to ImgBB',
      service: 'ImgBB',
      data: {
        url: uploadResult.url,
        displayUrl: uploadResult.displayUrl
      }
    });
    
  } catch (error) {
    console.error('Upload error:', error);
    
    return res.status(500).json({
      error: 'Upload failed',
      message: error.message,
      details: process.env.NODE_ENV === 'development' ? error.stack : undefined
    });
  }
}
