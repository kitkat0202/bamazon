DROP DATABASE IF EXISTS bamazon;
CREATE DATABASE bamazon;
USE bamazon;

CREATE TABLE products (
    item_id INTEGER(11) NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(30) NOT NULL,
    department_name VARCHAR(30),
    product_sales INTEGER(11) DEFAULT 0,
    price INTEGER(11) NOT NULL,
    stock_quantity INTEGER(11) NOT NULL,
    PRIMARY KEY (item_id)
);

CREATE TABLE departments(
    department_id INTEGER(11) NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(30) NOT NULL,
    over_head_costs INTEGER(11),
    PRIMARY KEY (department_id)
);

INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('Poland Spring Water', 'food', 2, 200);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('DELL Monitor', 'electronics', 600, 3);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('Office Chair', 'furniture', 50, 50);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('WISE Potato Chips', 'food', 2, 150);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('LogiTECH Computer Mouse', 'electronics', 25, 80);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('Cheese-its', 'food', 5, 170);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('NIKE Shoe Laces', 'clothing', 10, 1);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('Plush Pillow', 'furniture', 5, 9000);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('Fish Sticks', 'food', 35, 75);
INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('ANKR Battery Pack', 'electronics', 40, 80);

INSERT INTO departments (department_name, over_head_costs) VALUES ('food', '200');
INSERT INTO departments (department_name, over_head_costs) VALUES ('electronics', '1000');
INSERT INTO departments (department_name, over_head_costs) VALUES ('furniture', '700');
INSERT INTO departments (department_name, over_head_costs) VALUES ('clothing', '500');
INSERT INTO departments (department_name, over_head_costs) VALUES ('others', '100');

SELECT * FROM products;
SELECT item_id, product_name, price FROM products WHERE item_id="1";
UPDATE products SET product_sales= 4 WHERE item_id=7;
SELECT * FROM products;

SELECT * FROM departments;

SELECT department_id, departments.department_name, over_head_costs, SUM(product_sales) AS product_sales, (over_head_costs+product sales) AS Total
FROM departments
LEFT JOIN products ON departments.department_name = products.department_name
GROUP BY departments.department_name;



