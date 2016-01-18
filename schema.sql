DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS frequencies;
DROP TABLE IF EXISTS dates;


CREATE TABLE sales (
  id SERIAL PRIMARY KEY,
  amount VARCHAR(20),
  units_sold INTEGER,
  invoice_number INTEGER,
  employee_id INTEGER,
  product_id INTEGER,
  customer_id INTEGER,
  sale_frequency_id INTEGER,
  sale_date_id INTEGER
);

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE frequencies (
  id SERIAL PRIMARY KEY,
  frequency VARCHAR(20)
);

CREATE TABLE dates (
  id SERIAL PRIMARY KEY,
  date_sold DATE
);
