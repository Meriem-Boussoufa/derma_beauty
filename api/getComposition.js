const express = require("express");
const router = express.Router();
const {Sequelize} = require('sequelize');
const Composition = require('../models/Composition');
const ListComposition = require('../models/ListComposition')

router.get('/:id', async(req,res) =>  { 
    var barcode = req.params.id;
    const compositions = await ListComposition.findAll( 
        {
          attributes : ['productBarCode',[Sequelize.literal('"composition"."nameComposition"'), 'nameComposition'],[Sequelize.literal('"composition"."descComposition"'), 'descComposition']],
          where :{
            productBarCode : barcode
          },
          include : [
            { 
              model: Composition,
              attributes : []
            }
          ]
        }
        );
    if (compositions === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(compositions);
      }
  });
module.exports = router;