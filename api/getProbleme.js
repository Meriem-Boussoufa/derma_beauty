const express = require("express");
const router = express.Router();
const {Sequelize} = require('sequelize');
const ProblemePeau = require("../models/ProblemePeau");
const ListProblemePeau = require("../models/ListProblemePeau");


router.get('/', async(req,res) =>  { 
    const problemepeau = await ProblemePeau.findAll();
    if (problemepeau === null) {
        console.log('Not found!');
      } else {
        res.status(200).json(problemepeau);
      }
});

router.get('/:id', async(req,res) =>  { 
  var barcode = req.params.id;
  const problemepeau = await ListProblemePeau.findAll( 
      {
        attributes : ['productBarCode',[Sequelize.literal('"problemepeau"."nameProbleme"'), 'nameProbleme']],
        where :{
          productBarCode : barcode
        },
        include : [
          { 
            model: ProblemePeau,
            attributes : []
          }
        ]
      }
      );
  if (problemepeau === null) {
      console.log('Not found!');
    } else {
      res.status(200).json(problemepeau);
    }
});

module.exports = router;