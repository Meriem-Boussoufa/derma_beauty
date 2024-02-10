
const db = require ('./config/db');
const express = require('express');
const app = express();


app.use(express.urlencoded({ extended: true })); 
app.use(express.json());  


const apiRoutes = require('./api');
app.use('/api', apiRoutes);

// CONNECTION WITH DATABASE
db.authenticate().then(() => {
    console.log('Database connected ...');
 }).catch((error) => {
    console.error('Unable to connect to the database: ', error);
 });
 
// LISTEN TO PORT 
const server = app.listen(3000, () => {
    console.log(`The application started on port ${server.address().port}`);
});