create sequence new_cust_test cache 1000;
create sequence new_loyalty_test cache 1000;

create table customers_test (
cust_id uuid default gen_random_uuid() primary key,
secondary_cust_id int default nextval('new_cust_test'),
first_name string,
last_name string,
street_address string,
city string,
state string,
zip int,
phone string,
birthdate date);

create table loyalty_test (
loyalty_id uuid default gen_random_uuid() primary key,
cust_id uuid references customers (cust_id),
secondary_cust_id int default nextval('new_loyalty_test'),
start_date date,
total_points int,
total_points_this_year int,
total_transactions int,
total_transactions_this_year int,
last_purchase_date date,
loyalty_level string);


