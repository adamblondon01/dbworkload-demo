drop table if exists loyalty_levels cascade;
drop table if exists customers cascade;
drop table if exists loyalty cascade;
drop index if exists cust_indx;
drop index if exists loyalty_indx;
drop index if exists loyalty_cust_indx;
drop sequence if exists new_cust;
drop sequence if exists new_loyalty;

create sequence new_cust cache 1000;
create sequence new_loyalty cache 1000;

create table loyalty_levels (
loyalty_level_id uuid default gen_random_uuid() primary key,
level_name string,
min_points int,
max_points int);

create table customers (
cust_id uuid default gen_random_uuid() primary key,
secondary_cust_id int default nextval('new_cust'),
first_name string,
last_name string,
street_address string,
city string,
state string,
zip int,
phone string,
birthdate date);

create table loyalty (
loyalty_id uuid default gen_random_uuid() primary key,
cust_id uuid references customers (cust_id),
secondary_cust_id int default nextval('new_loyalty'),
start_date date,
total_points int,
total_points_this_year int,
total_transactions int,
total_transactions_this_year int,
last_purchase_date date,
loyalty_level string);

create unique index cust_indx on customers (secondary_cust_id) using hash;
create unique index loyalty_indx on loyalty (secondary_cust_id) using hash;
CREATE INDEX loyalty_cust_index on loyalty (cust_id) STORING (secondary_cust_id, start_date, total_points, total_points_this_year, total_transactions, total_transactions_this_year, last_purchase_date, loyalty_level);
