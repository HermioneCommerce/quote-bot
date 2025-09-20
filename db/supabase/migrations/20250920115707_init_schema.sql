-- pgcrypto for uuid
create extension if not exists "pgcrypto";

-----------------
-- Merchant Table
-----------------

create table if not exists merchants (
  id uuid primary key default gen_random_uuid(),
  admin_id uuid unique,
  name text not null,
  phone text,
  metadata jsonb default '{}'::jsonb,
  created_at timestamptz default now()
);

create index if not exists idx_merchants_admin_id on merchants(admin_id);


-----------------
-- Product Table
-----------------

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  merchant_id uuid not null references merchants(id) on delete cascade,
  sku text not null,
  name text not null,
  description text,
  price_cents integer not null default 0,
  unit text, -- e.g., "kg", "each"
  stock integer default 0,
  metadata jsonb default '{}'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index if not exists idx_products_merchant_id on products(merchant_id);

create or replace function on_product_update() returns trigger as 
$$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists trg_on_product_update on products;
create trigger trg_on_product_update
    before update on products
    for each row
    execute function on_product_update();

--------------------
-- Quotes Table
--------------------
create table if not exists quotes (
  id uuid primary key default gen_random_uuid(),
  merchant_id uuid not null references merchants(id) on delete cascade,
  customer_name text,
  customer_phone text not null,
  items_json jsonb not null default '[]'::jsonb, -- denormalized snapshot (optional)
  subtotal_cents integer,
  tax_cents integer default 0,
  total_cents integer,
  status text not null default 'draft', -- draft, sent, accepted, paid
  pdf_storage_path text, -- storage object path if using Supabase Storage
  metadata jsonb default '{}'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index if not exists idx_quotes_merchant_id on quotes(merchant_id);
create index if not exists idx_quotes_status on quotes(status);

drop trigger if exists trg_on_quote_update on quotes;
create trigger trg_on_quote_update
    before update on quotes
    for each row
    execute function on_product_update();

