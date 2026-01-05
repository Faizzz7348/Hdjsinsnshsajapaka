import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import ErrorBoundary from './ErrorBoundary.jsx'
import FlexibleScrollDemo from './FlexibleScrollDemo.jsx'
import './index-clean.css'
import 'primeicons/primeicons.css';
import 'leaflet/dist/leaflet.css';
import { performanceMonitor } from './utils/performance.js';

// Log environment for debugging
console.log('Environment:', import.meta.env.MODE);
console.log('Base URL:', import.meta.env.BASE_URL);

// Initialize performance monitoring
performanceMonitor;

const rootElement = document.getElementById('root');
if (!rootElement) {
  console.error('Root element not found!');
  document.body.innerHTML = '<div style="color: red; padding: 20px; font-family: sans-serif;"><h1>Error: Root element not found!</h1><p>Check console for details.</p></div>';
} else {
  console.log('Root element found, starting React app...');
  try {
    createRoot(rootElement).render(
      <StrictMode>
        <ErrorBoundary>
          <FlexibleScrollDemo />
        </ErrorBoundary>
      </StrictMode>,
    )
    console.log('React app rendered successfully!');
  } catch (error) {
    console.error('Failed to render app:', error);
    rootElement.innerHTML = `<div style="color: red; padding: 20px; font-family: sans-serif;">
      <h1>Error Loading Application</h1>
      <p><strong>Error:</strong> ${error.message}</p>
      <p><strong>Stack:</strong></p>
      <pre style="background: #f5f5f5; padding: 10px; overflow: auto;">${error.stack}</pre>
    </div>`;
  }
}


