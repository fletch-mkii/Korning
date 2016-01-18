require 'csv'
require "pg"
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "korning")
    yield(connection)
  ensure
    connection.close
  end
end

def read_csv
  CSV.readlines('sales.csv', headers:true)
end

def seed_table(query, header, header2 = nil, header3 = nil)
  inserted_data = []
  db_connection do |conn|
    read_csv.each do |line|
      if header2.nil?
        conn.exec_params(query,[line[header]]) unless inserted_data.include?(line[header])
      else
        employee_id = conn.exec_params("SELECT id FROM employees WHERE name = '#{line['employee']}';")[0]["id"]
        customer_id = conn.exec_params("SELECT id FROM customers WHERE name = '#{line['customer_and_account_no']}';")[0]["id"]
        product_id = conn.exec_params("SELECT id FROM products WHERE name = '#{line['product_name']}';")[0]["id"]
        date_id = conn.exec_params("SELECT id FROM dates WHERE date_sold = '#{line['sale_date']}';")[0]["id"]
        frequency_id = conn.exec_params("SELECT id FROM frequencies WHERE frequency = '#{line['invoice_frequency']}';")[0]["id"]
        conn.exec_params(query,[line[header],line[header2],line[header3],employee_id,customer_id,product_id,frequency_id,date_id]) unless inserted_data.include?(line[header])
      end
      inserted_data << line[header]
    end
  end
end

seed_table("INSERT INTO employees (name) VALUES($1);", "employee")
seed_table("INSERT INTO customers (name) VALUES($1);", "customer_and_account_no")
seed_table("INSERT INTO products (name) VALUES($1);", "product_name")
seed_table("INSERT INTO frequencies (frequency) VALUES($1);", "invoice_frequency")
seed_table("INSERT INTO dates (date_sold) VALUES($1);", "sale_date")
seed_table("INSERT INTO sales (amount, units_sold, invoice_number, employee_id, customer_id, product_id, sale_frequency_id, sale_date_id) VALUES($1, $2, $3, $4, $5, $6, $7, $8);", "sale_amount", "units_sold", "invoice_no")

##join stuff##
SELECT sales.id, name FROM sales JOIN employees ON (employees.id = sales.employee_id)
