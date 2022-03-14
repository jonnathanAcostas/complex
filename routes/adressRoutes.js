const AdressController = require('../controllers/adressController');
const passport = require('passport');

module.exports = (app)  => {

/*
*   GET ROUTES
*/

app.get('/api/adress/getAll',passport.authenticate('jwt', {session: false}),AdressController.getAllAdress); 


/*
*   POST ROUTES
*/


app.post('/api/adress/create',passport.authenticate('jwt', {session: false}),AdressController.create);
}