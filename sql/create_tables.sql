# Table 1: customers 
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    region VARCHAR2(50) NOT NULL
);
# Table 2: products
CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    category VARCHAR2(50) NOT NULL
);
# Table 3: transactions
CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    sale_date DATE NOT NULL,
    amount NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

# Insertion of sample data
# Customers data 
INSERT INTO customers VALUES (1001, 'John Doe', 'Kigali');
INSERT INTO customers VALUES (1002, 'Jane Smith', 'Kigali');
INSERT INTO customers VALUES (1003, 'Jean Bizimana', 'Western Province');
INSERT INTO customers VALUES (1004, 'Marie Uwase', 'Southern Province');
INSERT INTO customers VALUES (1005, 'Paul Kagame', 'Eastern Province');
INSERT INTO customers VALUES (1006, 'Sarah Brown', 'Western Province');
INSERT INTO customers VALUES (1007, 'Thomas Johnson', 'Southern Province');
INSERT INTO customers VALUES (1008, 'Anna Williams', 'Eastern Province');
INSERT INTO customers VALUES (1009, 'David Mugenzi', 'Kigali');
INSERT INTO customers VALUES (1010, 'Grace Uwimana', 'Kigali');

# Products data 
INSERT INTO products VALUES (2001, 'Inyange Milk', 'Dairy');
INSERT INTO products VALUES (2002, 'Inyange Yogurt', 'Dairy');
INSERT INTO products VALUES (2003, 'Inyange Juice', 'Beverages');
INSERT INTO products VALUES (2004, 'Inyange Water', 'Water');
INSERT INTO products VALUES (2005, 'Inyange Butter', 'Dairy');
INSERT INTO products VALUES (2006, 'Inyange Cheese', 'Dairy');

# Transactions data 
INSERT INTO transactions VALUES (3001, 1001, 2001, DATE '2024-01-15', 25000);
INSERT INTO transactions VALUES (3002, 1002, 2003, DATE '2024-01-20', 15000);
INSERT INTO transactions VALUES (3003, 1003, 2002, DATE '2024-01-25', 18000);
INSERT INTO transactions VALUES (3004, 1004, 2001, DATE '2024-02-05', 22000);
INSERT INTO transactions VALUES (3005, 1005, 2004, DATE '2024-02-10', 12000);
INSERT INTO transactions VALUES (3006, 1006, 2003, DATE '2024-02-15', 16000);
INSERT INTO transactions VALUES (3007, 1007, 2005, DATE '2024-02-20', 28000);
INSERT INTO transactions VALUES (3008, 1008, 2002, DATE '2024-03-01', 19000);
INSERT INTO transactions VALUES (3009, 1009, 2001, DATE '2024-03-05', 26000);
INSERT INTO transactions VALUES (3010, 1010, 2006, DATE '2024-03-10', 32000);
INSERT INTO transactions VALUES (3011, 1001, 2003, DATE '2024-03-15', 14000);
INSERT INTO transactions VALUES (3012, 1002, 2001, DATE '2024-03-20', 24000);
INSERT INTO transactions VALUES (3013, 1003, 2004, DATE '2024-04-01', 13000);
INSERT INTO transactions VALUES (3014, 1004, 2005, DATE '2024-04-05', 29000);
INSERT INTO transactions VALUES (3015, 1005, 2002, DATE '2024-04-10', 17000);