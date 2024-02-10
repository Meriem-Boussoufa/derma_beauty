const express = require("express");
const router = express.Router();
const {Sequelize } = require('sequelize');
const User = require('../models/User');


router.post("/user-register",async(req,res) => {
    // GET USER INPUT
    const nameuser = req.body.nameUser;
    const email = req.body.emailUser;
    const password = req.body.passwordUser;
    // VALIDATE USER INPUT
    if (nameuser && email && password){
        const users = await User.findAll(
            {
                where : {
                    emailUser : email,
                }
            }
        );
        if(users.length == 0){
            User.create({
                'nameUser': nameuser,
                'emailUser': email,
                'passwordUser':password
              });
              res.status(200).json(true);
        }else{
            res.status(200).json(false);
        }
    }else{
      console.log("All input is required");
      return res.status(400).json("All input is required");
    }
});//end of app.post()

router.post("/user-login",async(req,res) => {
    const nameuser = req.body.nameUser;
    const password = req.body.passwordUser;
    if(nameuser && password){
        const users = await User.findAll(
            {
                where : {
                    nameUser : nameuser,
                    passwordUser : password,
                }
            }
        );
        if(users.length == 0){
              res.status(200).json(false);
        }else{
            res.status(200).json(true);
        }
    }else{
        console.log("All input is required");
      return res.status(400).json("All input is required");
    }
}
);
module.exports = router;