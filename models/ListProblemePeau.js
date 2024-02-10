const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');

const Product = require('./Product');
const ProblemePeau = require('./ProblemePeau');

const ListProblemePeau = db.define('listproblemepeau' ,{});
ListProblemePeau.removeAttribute('id');

ProblemePeau.hasMany(ListProblemePeau);
ListProblemePeau.belongsTo(ProblemePeau)

Product.hasMany(ListProblemePeau);
ListProblemePeau.belongsTo(Product);

ListProblemePeau.sync().then(() => {
    console.log('ListProblemePeau table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : ', error);
 });
 
module.exports = ListProblemePeau;