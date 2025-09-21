
drop trigger if exists trg_on_product_update on products;
create trigger trg_on_product_update
    before update on products
    for each row
execute function on_product_update();

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

create index if not exists idx_quotes_merchant_id on quotes(merchant_id);
create index if not exists idx_quotes_status on quotes(status);

drop trigger if exists trg_on_quote_update on quotes;
create trigger trg_on_quote_update
    before update on quotes
    for each row
    execute function on_product_update();


drop trigger if exists trg_on_quote_update on quotes;
create trigger trg_on_quote_update
    before update on quotes
    for each row
execute function on_product_update();