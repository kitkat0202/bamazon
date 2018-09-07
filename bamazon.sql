DROP DATABASE IF EXISTS bamazon;
CREATE DATABASE bamazon;
USE bamazon;

CREATE TABLE products (
    item_id INTEGER(11) NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(30) NOT NULL,
    department_name VARCHAR(30),
    price INTEGER(11) NOT NULL,
    stock_quantity INTEGER(11) NOT NULL,
    PRIMARY KEY (item_id)
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


SELECT item_id, product_name, price FROM products WHERE item_id="1";
SELECT * FROM products;