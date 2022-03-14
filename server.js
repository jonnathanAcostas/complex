const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const logger = require('morgan');
const cors = require('cors');
const multer = require ('multer');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');
const passport = require('passport');
const session = require("express-session");

//INICILIZAR FIREBASE ADMIN

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
})

const upload = multer({
    storage: multer.memoryStorage()
})


/*
*RUTAS
*/

const users = require('./routes/usersRoutes');
const categories = require('./routes/categoriesRoutes');
const fields = require('./routes/fieldsRoutes');
const adress = require('./routes/adressRoutes');


const port = process.env.PORT || 3000;

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));
app.use(cors());
app.use(session({
     secret: 'SECRET',
     resave: false,
     saveUninitialized: true
    })
    );
    
app.use(passport.initialize());
app.use(passport.session());
require('./config/passport')(passport);


app.disable('x-powered-by');

app.set('port', port);


// LLAMANDO A LAS RUTAS
users(app, upload);
categories(app);
fields(app, upload);
adress(app, );


server.listen(3000, '192.168.1.36', function(){
    console.log('Aplicación de NodeJS ' +  port + ' Iniciada...')
});


//ERROR HANDLER

app.use((err, req, res, next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);

});

module.exports = {
    app: app,
    server: server
};