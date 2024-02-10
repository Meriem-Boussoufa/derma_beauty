const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');

const Product = require('./Product');
const Composition = require('./Composition');

const ListComposition = db.define('listcompositions' ,{});
ListComposition.removeAttribute('id');

Composition.hasOne(ListComposition);
ListComposition.belongsTo(Composition)


Product.hasOne(ListComposition);
ListComposition.belongsTo(Product)

ListComposition.sync().then(() => {
    console.log('ListComposition table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : ', error);
 });
 
module.exports = ListComposition;