const express = require("express");


const router = express.Router();

const productRouter = require('./getProduct');
const categoryRouter = require('./getCategory');
const typeRouter = require('./getType');
const problemeRouter = require('./getProbleme');
const compositionRouter = require('./getComposition');
const productsearchRouter = require('./getSearchProduct');
const users = require('./postUser');

router.use('/getProduct', productRouter);
router.use('/getCategory', categoryRouter);
router.use('/getType', typeRouter);
router.use('/getProbleme', problemeRouter);
router.use('/getComposition', compositionRouter);
router.use('/getSearchProduct', productsearchRouter);
router.use('/postUser',users);

module.exports = router;