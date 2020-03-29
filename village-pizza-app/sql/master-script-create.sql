create table pizza_size_type
(
pizza_size_id int(11) auto_increment primary key,
pizza_size varchar(45)
);


create table crust_type
(
crust_id int(11) auto_increment primary key,
crust_name varchar(45)
);


create table cheese_type
(
cheese_type_id int(11) auto_increment primary key,
cheese_name varchar(45)
);


create table sauce_type
(
sauce_type_id int(11) auto_increment primary key,
sauce_name varchar(45)
);


create table topping
(
topping_id int(11) auto_increment primary key,
topping_name varchar(45),
is_veg tinyint(1)
);



create table role
(
role_id int(11) auto_increment primary key,
role_name varchar(45)
);


create table employee
(
employee_id int(11) not null auto_increment,
employee_username varchar(256) not null,
employee_password varchar(256) not null,
role_id int(11) not null,
constraint employee_pk primary key (employee_id),
constraint employee_role_fk foreign key (role_id) references role(role_id)
);


create table customer
(
cust_id int(11) not null auto_increment,
cust_username varchar(256) not null,
cust_password varchar(256) not null,
cust_first_name varchar(256) not null,
cust_last_name varchar(256) not null,
role_id int(11) not null,
constraint customer_pk primary key (cust_id),
constraint customer_role_fk foreign key (role_id) references role(role_id)
);


create table customer_detail
(
cust_detail_id int(11) not null auto_increment,
cust_id int(11) not null,
cust_street varchar(256) not null,
cust_apt_no varchar(45) null,
cust_city varchar(45) not null,
cust_state varchar(45) not null,
cust_country varchar(45) not null,
cust_zip_code varchar(5) not null,
cust_email_id varchar(256) null,
cust_phone_no varchar(10) not null,
constraint cust_detail_pk primary key (cust_detail_id),
constraint cust_detail_customer_fk foreign key (cust_id) references customer(cust_id)
);


create table order_status
(
order_status_id int(11) auto_increment primary key,
order_status_value varchar(45) not null
);


create table customer_order
(
customer_order_id int(11) auto_increment,
cust_id int(11) not null,
order_received_by int(11) not null,
order_delivered_by int(11) not null,
order_status_id int(11) not null,
order_date datetime not null default current_timestamp on update current_timestamp,
constraint order_pk primary key (customer_order_id),
constraint order_cust_fk foreign key (cust_id) references customer(cust_id),
constraint order_employee_fk1 foreign key (order_received_by) references employee(employee_id),
constraint order_employee_fk2 foreign key (order_delivered_by) references employee(employee_id),
constraint order_status_fk foreign key (order_status_id) references order_status(order_status_id)
);


create table user_transaction
(
user_transaction_id int(11) not null auto_increment,
customer_order_id int(11) not null,
cust_id int(11) not null,
transaction_type varchar(45) not null, -- cash or credit/debit
transaction_status varchar(45) not null, -- success or failed
transaction_date datetime not null default current_timestamp on update current_timestamp,
constraint transaction_pk primary key (user_transaction_id),
constraint transaction_cust_fk foreign key (cust_id) references customer(cust_id),
constraint transaction_order_fk foreign key (customer_order_id) references customer_order(customer_order_id)
);


create table pizza
(
pizza_id int(11) not null  auto_increment ,
pizza_size_type_id int(11) not null,
crust_id int(11) not null,
cheese_type_id int(11) not null,
toppings varchar(4000) not null,
customer_order_id int(11) not null,
quantity int(11) not null default '1',
constraint pizza_pk primary key (pizza_id),
constraint pizza_size_type_fk foreign key (pizza_size_type_id) references pizza_size_type(pizza_size_id),
constraint pizza_crust_fk foreign key (crust_id) references crust_type(crust_id),
constraint pizza_cheese_type_fk foreign key (cheese_type_id) references cheese_type(cheese_type_id),
constraint pizza_order_fk foreign key (customer_order_id) references customer_order(customer_order_id)
);
