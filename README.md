# Fototela Events — App de gestión

App de gestión interna para Fototela Events (clientes, presupuestos, facturas, calendario).

## Tecnología
- HTML, CSS y JavaScript puro (sin frameworks, sin instalación)
- Base de datos: Supabase (PostgreSQL en la nube)
- Login con email y contraseña (Supabase Auth)
- Publicado en Vercel

## Cómo se actualiza
1. Pide los cambios a Claude
2. Sustituye el contenido de `index.html` por el que te dé Claude
3. Sube el cambio a GitHub (commit)
4. Vercel lo publica automáticamente en 1-2 minutos

## Seguridad
- Row Level Security (RLS) activado en Supabase: cada usuario solo ve sus propios datos
- La clave usada en el código es la "publishable key", diseñada para ser pública
- Las contraseñas nunca se guardan en el código, las gestiona Supabase Auth
