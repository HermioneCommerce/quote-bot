with merchant as (
  insert into merchants (id, name, phone) 
  values (gen_random_uuid(), 'Acme Supplies', '+27123456789')
  returning id
),
p1 as (
  insert into products (merchant_id, sku, name, description, price_cents, unit, stock)
  select id, 'SKU-001', 'Hammer', 'Heavy duty steel hammer', 1500, 'each', 10 from merchant
  returning id, merchant_id
),
p2 as (
  insert into products (merchant_id, sku, name, description, price_cents, unit, stock)
  select id, 'SKU-002', 'Nails Pack', 'Box of 100 nails', 500, 'box', 50 from merchant
  returning id, merchant_id
),
q as (
  insert into quotes (merchant_id, customer_name, customer_phone, subtotal_cents, total_cents, status)
  select id, 'John Doe', '+27876543210', 2500, 2500, 'draft' from merchant
  returning id
)
insert into quote_items (quote_id, product_id, description, qty, price_cents, line_total_cents)
select q.id, p1.id, 'Hammer', 1, 1500, 1500 from q, p1
union all
select q.id, p2.id, 'Nails Pack', 2, 500, 1000 from q, p2;
