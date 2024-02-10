const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');
const Product = require('./Product');

const ProblemePeau = db.define('problemepeaus' ,{
    idProbleme :{
        type:DataTypes.BIGINT,
        allowNull: false,
        primaryKey: true,
        validate :{
            notEmpty : true
        }
    },
    nameProbleme :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
});

ProblemePeau.sync().then(() => {
    console.log('ProblemePeau table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : ProblemePeau', error);
 });
 
module.exports = ProblemePeau;