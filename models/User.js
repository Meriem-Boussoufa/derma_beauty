const {Sequelize, DataTypes} = require('sequelize');
const db = require ('../config/db');

const User = db.define('users' ,{
    idUser :{ 
        type:DataTypes.BIGINT,
        allowNull: false,
        primaryKey: true,
        autoIncrement:true,
        validate :{
            notEmpty : true
        }
    },
    nameUser :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
    emailUser :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
    passwordUser :{
        type:DataTypes.CHAR,
        allowNull: false,
        validate :{
            notEmpty : true
        }
    },
});

User.sync().then(() => {
    console.log('User table created successfully!');
 }).catch((error) => {
    console.error('Unable to create table : User', error);
 });
 
module.exports = User;