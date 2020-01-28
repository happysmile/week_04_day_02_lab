DROP TABLE pizza_orders;

CREATE TABLE pizza_orders (
  id SERIAL primary key,
  first_name varchar(255),
  last_name varchar(255),
  topping varchar(255),
  quantity INT
);