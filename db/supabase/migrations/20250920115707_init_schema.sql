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

--------------------
-- Quote Items Table
--------------------

create table if not exists quote_items (
  id uuid primary key default gen_random_uuid(),
  quote_id uuid not null references quotes(id) on delete cascade,
  product_id uuid references products(id),
  description text,
  qty integer not null default 1,
  price_cents integer not null, -- price used at time of quote (snapshot)
  line_total_cents integer not null,
  created_at timestamptz default now()
);

create index if not exists quote_items_quote_id_idx on quote_items(quote_id);
create index if not exists quote_items_product_id_idx on quote_items(product_id);

--------------------
-- Incoming Messages
--------------------

create table if not exists incoming_messages (
  id uuid primary key default gen_random_uuid(),
  source text not null, -- e.g. 'twilio', 'meta'
  raw_payload jsonb,
  from_phone text,
  to_phone text,
  body text,
  handled boolean default false,
  created_at timestamptz default now()
);

-----------------------------
-- quote_audit (tool / agent logs)
-----------------------------
create table if not exists quote_audit (
  id uuid primary key default gen_random_uuid(),
  quote_id uuid references quotes(id) on delete cascade,
  actor text, -- 'agent' | 'user' | 'system'
  action text,
  payload jsonb,
  created_at timestamptz default now()
);

-----------------------------
-- Row Level Security (RLS) : basic tenancy model
-- This example assumes merchants are created and linked to auth.users via merchants.user_id
-- Policies use auth.uid() which is provided by Supabase Auth in requests
-----------------------------

-- Enable RLS on tables we want to protect
alter table products enable row level security;
alter table quotes enable row level security;
alter table quote_items enable row level security;
alter table merchants enable row level security;

-- Helper policy: merchants can manage their merchant row
create policy merchants_owner_select on merchants
  for select
  using (user_id = auth.uid());

create policy merchants_owner_insert on merchants
  for insert
  with check (user_id = auth.uid());

create policy merchants_owner_update on merchants
  for update
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- Products: allow merchant to select/insert/update/delete for their merchant_id
create policy products_for_merchant_select on products
  for select
  using (
    merchant_id in (select id from merchants where user_id = auth.uid())
  );

create policy products_for_merchant_insert on products
  for insert
  with check (
    merchant_id in (select id from merchants where user_id = auth.uid())
  );

create policy products_for_merchant_update on products
  for update
  using (
    merchant_id in (select id from merchants where user_id = auth.uid())
  )
  with check (
    merchant_id in (select id from merchants where user_id = auth.uid())
  );

create policy products_for_merchant_delete on products
  for delete
  using (
    merchant_id in (select id from merchants where user_id = auth.uid())
  );

-- Quotes: allow merchant to access their quotes
create policy quotes_for_merchant_select on quotes
  for select
  using (
    merchant_id in (select id from merchants where user_id = auth.uid())
  );

create policy quotes_for_merchant_insert on quotes
  for insert
  with check (
    merchant_id in (select id from merchants where user_id = auth.uid())
  );

create policy quotes_for_merchant_update on quotes
  for update
  using (
    merchant_id in (select id from merchants where user_id = auth.uid())
  )
  with check (
    merchant_id in (select id from merchants where user_id = auth.uid())
  );

create policy quotes_for_merchant_delete on quotes
  for delete
  using (
    merchant_id in (select id from merchants where user_id = auth.uid())
  );

-- Quote items: allow operations if parent quote belongs to merchant
create policy quote_items_for_merchant_select on quote_items
  for select
  using (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where user_id = auth.uid()))
  );

create policy quote_items_for_merchant_insert on quote_items
  for insert
  with check (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where user_id = auth.uid()))
  );

create policy quote_items_for_merchant_update on quote_items
  for update
  using (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where user_id = auth.uid()))
  )
  with check (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where user_id = auth.uid()))
  );

create policy quote_items_for_merchant_delete on quote_items
  for delete
  using (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where user_id = auth.uid()))
  );

-----------------------------
-- Useful view: normalized quote with items (optional)
-----------------------------
create or replace view quotes_with_items as
select
  q.*,
  (
    select json_agg(row_to_json(ri))
    from (
      select qi.id, qi.description, qi.qty, qi.price_cents, qi.line_total_cents
      from quote_items qi
      where qi.quote_id = q.id
      order by qi.created_at
    ) ri
  ) as items
from quotes q;

-----------------------------
-- Optional sample data (uncomment for local testing only)
-----------------------------
-- insert into merchants (id, user_id, name, phone) values (gen_random_uuid(), '00000000-0000-0000-0000-000000000000', 'Demo Merchant', '+27123456789');
-- insert into products (merchant_id, sku, name, price_cents, unit, stock) values ((select id from merchants limit 1), 'RICE-2KG', 'Rice 2kg', 2500, 'each', 100);
-- insert into products (merchant_id, sku, name, price_cents, unit, stock) values ((select id from merchants limit 1), 'OIL-1L', 'Cooking Oil 1L', 1800, 'each', 50);
