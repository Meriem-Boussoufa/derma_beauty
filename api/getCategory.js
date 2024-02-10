const express = require("express");
const router = express.Router();

const Category = require("../models/Category");
const Product = require("../models/Product");

router.get('/', async(req,res) =>  { 
    const category = await Category.findAll();
    if (category === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(category);
      }
});

router.get('/getProductByCategory/:idCat', async(req,res) => {
  var idCat = req.params.idCat;
  const product = await Product.findAll(
    {
      where : {
        categoryIdCategory : idCat,
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