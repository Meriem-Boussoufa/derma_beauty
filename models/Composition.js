const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');
const Product = require('./Product');

const Composition = db.define('compositions' ,{
    idComposition :{
        type:DataTypes.BIGINT,
        allowNull: false,
        primaryKey: true,
        validate :{
            notEmpty : true
        }
    },
    nameComposition :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
    descComposition :{
        type:DataTypes.TEXT,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
});

Composition.sync().then(() => {
    console.log('Composition table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : Composition', error);
 });
 
module.exports = Composition;