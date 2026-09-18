// ============================================================
// Configuración de conexión a Supabase
// ============================================================
// Proyecto: veqkogmavfxysmvfgbzt
// La "anon public key" es segura para usar en el navegador (frontend):
// solo permite lo que las políticas RLS de la base de datos autoricen.
// NUNCA pongas aquí la "service_role key": esa es secreta y solo debe
// usarse en un servidor.

const SUPABASE_URL = 'https://veqkogmavfxysmvfgbzt.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZlcWtvZ21hdmZ4eXNtdmZnYnp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODk3MzY5NDcsImV4cCI6MjEwNTMxMjk0N30.5-Gqi-oXsd85vq7h-u72xJ8O-McNCIrYm9jmXZWpMbs';

// Cliente global de Supabase (usa la librería cargada por CDN en index.html)
const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
