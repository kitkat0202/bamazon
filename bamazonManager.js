var mysql = require("mysql");
require("dotenv").config();
var inquirer = require("inquirer");
const cTable = require('console.table');

var connection = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: process.env.MYSQL_DB_PW,
    database: "bamazon"
})


// Variables
let currentProducts = []


// FUNCTIONS
let runManager = () => {
    inquirer.prompt({
        name: "action",
        type: "list",
        message: "What would you like to do?",
        choices: [
            "View Products for Sale",
            "View Low Inventory",
            "Add to Inventory",
            "Add New Product"
        ]
    }).then(function(answer) {
        switch (answer.action) {
            case "View Products for Sale":
                viewSales()
                break

            case "View Low Inventory":
                viewLow()
                break

            case "Add to Inventory":
                createArray()
                break;

            case "Add New Product":
                newInv()
                break
        }
    });
}


let viewSales = () => {
    connection.query(`SELECT item_id, product_name, price, stock_quantity FROM products`, function(err, res) {
        if (err) throw err
        console.log(`\n   ~ ~ ~  PRODUCT TABLE  ~ ~ ~\n`)
        console.table(res)
        console.log("---------------------------------------------------------------------\n\n")
        runManager()
    })
}

let viewLow = () => {
    connection.query(`SELECT item_id, product_name, stock_quantity FROM products WHERE stock_quantity<5`, function(err, res) {
        if (err) throw err
        console.log(`\n   ~ ~ ~  LOW STOCK TABLE  ~ ~ ~\n`)
        console.table(res)
        console.log("---------------------------------------------------------------------\n\n")
        runManager()
    })
}

let createArray = () => {
    connection.query(`SELECT product_name FROM products`, function(err, res) {
        if (err) throw err
        for (let i = 0; i < res.length; i++) {
            currentProducts.push(res[i].product_name)
        }
        addInv()
    })
}

let addInv = () => {
    inquirer.prompt([
        {
            name: "item",
            type: "list",
            message: "Which item would you like to add inventory to?",
            choices: currentProducts
        },
        {
            name: "quantity",
            type: "input",
            message: "how many would you like to add?",
            validate: function(value) {
                if (Number.isInteger(parseInt(value)) && value > 0) {
                    return true
                } else {
                    return `${value} is not a vaid quantity`
                }
            }
        }
    ]).then(function(answers) {
        connection.query("SELECT product_name, stock_quantity FROM products WHERE ?", { product_name: answers.item }, function(err, res) {
            let product = res[0]
            let quant = parseInt(product.stock_quantity) + parseInt(answers.quantity)
            if (err) throw err
            connection.query('UPDATE products SET ? WHERE ?', [ {stock_quantity:(quant)}, {product_name: product.product_name} ], function(err, res) {
                if (err) throw err
                console.log(`${product.product_name} stock is now updated to ${quant}`)
                runManager()
            })
        })
    })
    
}

let newInv = () => {
    inquirer.prompt([
        {
            name: "name",
            type: "input",
            message: "Name: ",
            validate: function(value) {
                if (value) {
                  return true
                } else {
                    return `${value} is not a vaid name`
                }
            }
        },
        {
            name: "department",
            type: "list",
            message: "Department: ",
            choices: [
                "food",
                "electronics",
                "furniture",
                "clothing",
                "other"
            ]
        },
        {
            name: "price",
            type: "input",
            message: "Price: ",
            validate: function(value) {
                if (Number.isNaN(parseInt(value)) === false && value > 0) {
                    return true
                } else {
                    return `${value} is not a vaid price`
                }
            }
        },
        {
            name: "stock",
            type: "input",
            message: "Stock Quantity: ",
            validate: function(value) {
                if (Number.isNaN(parseInt(value)) === false && value > 0) {
                    return true
                } else {
                    return `${value} is not a vaid stock number`
                }
            }
        }
    ]).then (function(answers) {
        console.log(`\n\nNEW PRODUCT:\n     Name: ${answers.name}\n     Dept: ${answers.department}\n     Price: ${answers.price}\n     Stock: ${answers.stock}\n\n`)

        connection.query(`INSERT INTO products (product_name, department_name, price, stock_quantity) VALUES ('${answers.name}', '${answers.department}', ${answers.price}, ${answers.stock})`, function(err, res) {
            if (err) throw err
            runManager()
        })
    })
}



// RUNNING
connection.connect(function(err) {
    if (err) throw err
    runManager()
})