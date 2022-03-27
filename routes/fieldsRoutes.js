const FieldsController = require('../controllers/fieldsController');
const passport = require('passport');

module.exports =(app, upload) => {

app.get('/api/fields/findByCategory/:id_category',passport.authenticate('jwt', {session: false}),  FieldsController.findByCategory);
app.get('/api/fields/findByCategoryField/:id_category',passport.authenticate('jwt', {session: false}),  FieldsController.findByCategoryField);
app.post('/api/fields/create/:id_adress',passport.authenticate('jwt', {session: false}), upload.array('image', 2), FieldsController.create);

}