const express = require("express");
const router = express.Router();
const {Sequelize } = require('sequelize');
const Product = require('../models/Product');


router.get("/", async(req,res) =>{
    const product = await Product.findAll();
    if (product === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(product);
      }
});


router.get("/searchBar", async(req,res) => {
    const name = req.query.nameProduct;
    const product = await Product.findAll(
        {
            where: {
                nameProduct : name,
            }
        }
    );
    if (product === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(product);
      }
  });
  
  module.exports = router;