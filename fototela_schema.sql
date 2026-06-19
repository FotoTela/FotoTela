-- ============================================
-- FOTOTELA EVENTS — Esquema de base de datos
-- ============================================

-- Tabla de clientes
create table clientes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null default auth.uid(),
  nombre text not null,
  dni text,
  telefono text,
  email text,
  direccion text,
  ciudad text,
  cp text,
  tipo_evento text,
  fecha_evento date,
  servicio text,
  importe numeric default 0,
  reserva numeric default 0,
  notas text,
  estado text default 'Activo',
  created_at timestamptz default now()
);

-- Tabla de presupuestos
create table presupuestos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null default auth.uid(),
  numero text not null,
  cliente_id uuid references clientes(id) on delete cascade,
  servicio text,
  fecha_evento date,
  base numeric default 0,
  iva_pct numeric default 21,
  iva_eur numeric default 0,
  total numeric default 0,
  senal numeric default 0,
  notas text,
  estado text default 'Pendiente',
  created_at timestamptz default now()
);

-- Tabla de facturas
create table facturas (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null default auth.uid(),
  numero text not null,
  cliente_id uuid references clientes(id) on delete cascade,
  fecha_factura date,
  fecha_evento date,
  descripcion text,
  base numeric default 0,
  iva_pct numeric default 21,
  iva_eur numeric default 0,
  total numeric default 0,
  cobrado numeric default 0,
  pendiente numeric default 0,
  observaciones text,
  estado text default 'Pendiente',
  created_at timestamptz default now()
);

-- ============================================
-- SEGURIDAD: Row Level Security (RLS)
-- Cada usuario solo ve sus propios datos
-- ============================================

alter table clientes enable row level security;
alter table presupuestos enable row level security;
alter table facturas enable row level security;

-- Políticas para CLIENTES
create policy "Los usuarios ven solo sus clientes"
  on clientes for select using (auth.uid() = user_id);
create policy "Los usuarios crean sus clientes"
  on clientes for insert with check (auth.uid() = user_id);
create policy "Los usuarios editan sus clientes"
  on clientes for update using (auth.uid() = user_id);
create policy "Los usuarios borran sus clientes"
  on clientes for delete using (auth.uid() = user_id);

-- Políticas para PRESUPUESTOS
create policy "Los usuarios ven solo sus presupuestos"
  on presupuestos for select using (auth.uid() = user_id);
create policy "Los usuarios crean sus presupuestos"
  on presupuestos for insert with check (auth.uid() = user_id);
create policy "Los usuarios editan sus presupuestos"
  on presupuestos for update using (auth.uid() = user_id);
create policy "Los usuarios borran sus presupuestos"
  on presupuestos for delete using (auth.uid() = user_id);

-- Políticas para FACTURAS
create policy "Los usuarios ven solo sus facturas"
  on facturas for select using (auth.uid() = user_id);
create policy "Los usuarios crean sus facturas"
  on facturas for insert with check (auth.uid() = user_id);
create policy "Los usuarios editan sus facturas"
  on facturas for update using (auth.uid() = user_id);
create policy "Los usuarios borran sus facturas"
  on facturas for delete using (auth.uid() = user_id);
