create schema if not exists "api";

drop extension if exists "pg_net";

revoke delete on table "public"."incoming_messages" from "anon";

revoke insert on table "public"."incoming_messages" from "anon";

revoke references on table "public"."incoming_messages" from "anon";

revoke select on table "public"."incoming_messages" from "anon";

revoke trigger on table "public"."incoming_messages" from "anon";

revoke truncate on table "public"."incoming_messages" from "anon";

revoke update on table "public"."incoming_messages" from "anon";

revoke delete on table "public"."incoming_messages" from "authenticated";

revoke insert on table "public"."incoming_messages" from "authenticated";

revoke references on table "public"."incoming_messages" from "authenticated";

revoke select on table "public"."incoming_messages" from "authenticated";

revoke trigger on table "public"."incoming_messages" from "authenticated";

revoke truncate on table "public"."incoming_messages" from "authenticated";

revoke update on table "public"."incoming_messages" from "authenticated";

revoke delete on table "public"."incoming_messages" from "service_role";

revoke insert on table "public"."incoming_messages" from "service_role";

revoke references on table "public"."incoming_messages" from "service_role";

revoke select on table "public"."incoming_messages" from "service_role";

revoke trigger on table "public"."incoming_messages" from "service_role";

revoke truncate on table "public"."incoming_messages" from "service_role";

revoke update on table "public"."incoming_messages" from "service_role";

revoke delete on table "public"."merchants" from "anon";

revoke insert on table "public"."merchants" from "anon";

revoke references on table "public"."merchants" from "anon";

revoke select on table "public"."merchants" from "anon";

revoke trigger on table "public"."merchants" from "anon";

revoke truncate on table "public"."merchants" from "anon";

revoke update on table "public"."merchants" from "anon";

revoke delete on table "public"."merchants" from "authenticated";

revoke insert on table "public"."merchants" from "authenticated";

revoke references on table "public"."merchants" from "authenticated";

revoke select on table "public"."merchants" from "authenticated";

revoke trigger on table "public"."merchants" from "authenticated";

revoke truncate on table "public"."merchants" from "authenticated";

revoke update on table "public"."merchants" from "authenticated";

revoke delete on table "public"."merchants" from "service_role";

revoke insert on table "public"."merchants" from "service_role";

revoke references on table "public"."merchants" from "service_role";

revoke select on table "public"."merchants" from "service_role";

revoke trigger on table "public"."merchants" from "service_role";

revoke truncate on table "public"."merchants" from "service_role";

revoke update on table "public"."merchants" from "service_role";

revoke delete on table "public"."products" from "anon";

revoke insert on table "public"."products" from "anon";

revoke references on table "public"."products" from "anon";

revoke select on table "public"."products" from "anon";

revoke trigger on table "public"."products" from "anon";

revoke truncate on table "public"."products" from "anon";

revoke update on table "public"."products" from "anon";

revoke delete on table "public"."products" from "authenticated";

revoke insert on table "public"."products" from "authenticated";

revoke references on table "public"."products" from "authenticated";

revoke select on table "public"."products" from "authenticated";

revoke trigger on table "public"."products" from "authenticated";

revoke truncate on table "public"."products" from "authenticated";

revoke update on table "public"."products" from "authenticated";

revoke delete on table "public"."products" from "service_role";

revoke insert on table "public"."products" from "service_role";

revoke references on table "public"."products" from "service_role";

revoke select on table "public"."products" from "service_role";

revoke trigger on table "public"."products" from "service_role";

revoke truncate on table "public"."products" from "service_role";

revoke update on table "public"."products" from "service_role";

revoke delete on table "public"."quote_audit" from "anon";

revoke insert on table "public"."quote_audit" from "anon";

revoke references on table "public"."quote_audit" from "anon";

revoke select on table "public"."quote_audit" from "anon";

revoke trigger on table "public"."quote_audit" from "anon";

revoke truncate on table "public"."quote_audit" from "anon";

revoke update on table "public"."quote_audit" from "anon";

revoke delete on table "public"."quote_audit" from "authenticated";

revoke insert on table "public"."quote_audit" from "authenticated";

revoke references on table "public"."quote_audit" from "authenticated";

revoke select on table "public"."quote_audit" from "authenticated";

revoke trigger on table "public"."quote_audit" from "authenticated";

revoke truncate on table "public"."quote_audit" from "authenticated";

revoke update on table "public"."quote_audit" from "authenticated";

revoke delete on table "public"."quote_audit" from "service_role";

revoke insert on table "public"."quote_audit" from "service_role";

revoke references on table "public"."quote_audit" from "service_role";

revoke select on table "public"."quote_audit" from "service_role";

revoke trigger on table "public"."quote_audit" from "service_role";

revoke truncate on table "public"."quote_audit" from "service_role";

revoke update on table "public"."quote_audit" from "service_role";

revoke delete on table "public"."quote_items" from "anon";

revoke insert on table "public"."quote_items" from "anon";

revoke references on table "public"."quote_items" from "anon";

revoke select on table "public"."quote_items" from "anon";

revoke trigger on table "public"."quote_items" from "anon";

revoke truncate on table "public"."quote_items" from "anon";

revoke update on table "public"."quote_items" from "anon";

revoke delete on table "public"."quote_items" from "authenticated";

revoke insert on table "public"."quote_items" from "authenticated";

revoke references on table "public"."quote_items" from "authenticated";

revoke select on table "public"."quote_items" from "authenticated";

revoke trigger on table "public"."quote_items" from "authenticated";

revoke truncate on table "public"."quote_items" from "authenticated";

revoke update on table "public"."quote_items" from "authenticated";

revoke delete on table "public"."quote_items" from "service_role";

revoke insert on table "public"."quote_items" from "service_role";

revoke references on table "public"."quote_items" from "service_role";

revoke select on table "public"."quote_items" from "service_role";

revoke trigger on table "public"."quote_items" from "service_role";

revoke truncate on table "public"."quote_items" from "service_role";

revoke update on table "public"."quote_items" from "service_role";

revoke delete on table "public"."quotes" from "anon";

revoke insert on table "public"."quotes" from "anon";

revoke references on table "public"."quotes" from "anon";

revoke select on table "public"."quotes" from "anon";

revoke trigger on table "public"."quotes" from "anon";

revoke truncate on table "public"."quotes" from "anon";

revoke update on table "public"."quotes" from "anon";

revoke delete on table "public"."quotes" from "authenticated";

revoke insert on table "public"."quotes" from "authenticated";

revoke references on table "public"."quotes" from "authenticated";

revoke select on table "public"."quotes" from "authenticated";

revoke trigger on table "public"."quotes" from "authenticated";

revoke truncate on table "public"."quotes" from "authenticated";

revoke update on table "public"."quotes" from "authenticated";

revoke delete on table "public"."quotes" from "service_role";

revoke insert on table "public"."quotes" from "service_role";

revoke references on table "public"."quotes" from "service_role";

revoke select on table "public"."quotes" from "service_role";

revoke trigger on table "public"."quotes" from "service_role";

revoke truncate on table "public"."quotes" from "service_role";

revoke update on table "public"."quotes" from "service_role";

alter table "public"."incoming_messages" enable row level security;

alter table "public"."quote_audit" enable row level security;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.on_product_update()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.updated_at = now();
  return new;
end;
$function$
;


