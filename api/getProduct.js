const express = require("express");
const router = express.Router();
const {Sequelize } = require('sequelize');
const Product = require('../models/Product');
const TypePeau = require('../models/TypePeau');
const Category = require('../models/Category');
const ListProblemePeau = require('../models/ListProblemePeau');
const ListComposition = require('../models/ListComposition');

/*ListComposition.create({
    'compositionIdComposition' : 1,
    'productBarCode' : 3574661287225
})
ListProblemePeau.create({
    'problemepeauIdProbleme': 6,
    'productBarCode': 3574661287225
})
*/
    router.get('/:id', async(req,res) =>  { 
    var barcode = req.params.id;
    const product = await Product.findByPk(barcode,{
        attributes  : ['barCode','nameProduct','descProduct','pathimage',[Sequelize.literal('"category"."nameCategory"'), 'nameCategory'],[Sequelize.literal('"typepeau"."nameTypePeau"'), 'nameTypePeau'],],
        include : [
            {
                model:Category,
                as : 'category',
                attributes :[]
            },
            {
                model : TypePeau,
                as : 'typepeau',
                attributes :[]
            }
        ]
    });
    if (product === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(product);
      }
});

router.get('/:idcat/:idtype/:element/', async(req,res) =>{
    var idcat = req.params.idcat;
    var idtype = req.params.idtype;
    var idprobleme = req.params.element;
    const product = await ListProblemePeau.findAll({ 
        attributes : ['problemepeauIdProbleme','productBarCode',[Sequelize.literal('"product"."barCode"'), 'barCode'],[Sequelize.literal('"product"."nameProduct"'), 'nameProduct'],[Sequelize.literal('"product"."pathimage"'), 'pathimage']],
        where:
        {
            problemepeauIdProbleme : idprobleme
        },
        include : [
            {
                model : Product,
                attributes : [],

                where:{
                    typepeauIdTypePeau : idtype,
                    categoryIdCategory : idcat,
                }
            }
        ],

    }
    );
    if (product === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(product);
      }
})
  module.exports = router;
