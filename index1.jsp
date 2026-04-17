// Simple E-commerce Backend (Node.js + Express)
// Run: npm init -y && npm install express body-parser

const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

// In-memory data
let products = [
  { id: 1, name: 'Laptop', price: 50000 },
  { id: 2, name: 'Phone', price: 20000 }
];

let cart = [];

// Get all products
app.get('/products', (req, res) => {
  res.json(products);
});

// Get single product
app.get('/products/:id', (req, res) => {
  const product = products.find(p => p.id == req.params.id);
  res.json(product);
});

// Add product (admin)
app.post('/products', (req, res) => {
  const product = {
    id: products.length + 1,
    name: req.body.name,
    price: req.body.price
  };
  products.push(product);
  res.json(product);
});

// Add to cart
app.post('/cart', (req, res) => {
  const product = products.find(p => p.id == req.body.productId);
  if (!product) return res.status(404).send('Product not found');

  cart.push(product);
  res.json(cart);
});

// View cart
app.get('/cart', (req, res) => {
  res.json(cart);
});

// Checkout
app.post('/checkout', (req, res) => {
  let total = cart.reduce((sum, item) => sum + item.price, 0);
  cart = [];
  res.json({ message: 'Order placed', total });
});

// Start server
app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});
