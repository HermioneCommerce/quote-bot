-- Helper policy: merchants can manage their merchant row
create policy merchants_owner_select on merchants
    for select
    using (id = auth.uid());

create policy merchants_owner_insert on merchants
    for insert
    with check (id = auth.uid());

create policy merchants_owner_update on merchants
    for update
    using (id = auth.uid())
    with check (id = auth.uid());

-- Products: allow merchant to select/insert/update/delete for their merchant_id
create policy products_for_merchant_select on products
  for select
  using (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  );

create policy products_for_merchant_insert on products
  for insert
  with check (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  );

create policy products_for_merchant_update on products
  for update
  using (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  )
  with check (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  );

create policy products_for_merchant_delete on products
  for delete
  using (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  );


-- Quotes: allow merchant to access their quotes
create policy quotes_for_merchant_select on quotes
  for select
  using (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  );

create policy quotes_for_merchant_insert on quotes
  for insert
  with check (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  );

create policy quotes_for_merchant_update on quotes
  for update
  using (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  )
  with check (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  );

create policy quotes_for_merchant_delete on quotes
  for delete
  using (
    merchant_id in (select id from merchants where merchant_id = auth.uid())
  );

-- Quote items: allow operations if parent quote belongs to merchant
create policy quote_items_for_merchant_select on quote_items
  for select
  using (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where merchant_id = auth.uid()))
  );

create policy quote_items_for_merchant_insert on quote_items
  for insert
  with check (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where merchant_id = auth.uid()))
  );

create policy quote_items_for_merchant_update on quote_items
  for update
  using (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where merchant_id = auth.uid()))
  )
  with check (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where merchant_id = auth.uid()))
  );

create policy quote_items_for_merchant_delete on quote_items
  for delete
  using (
    quote_id in (select id from quotes where merchant_id in (select id from merchants where merchant_id = auth.uid()))
  );
