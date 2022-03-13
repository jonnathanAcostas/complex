const FieldsController = require('../controllers/fieldsController');
const passport = require('passport');

module.exports =(app, upload) => {

app.get('/api/fields/findByCategory/:id_category',passport.authenticate('jwt', {session: false}),  FieldsController.findByCategory);
app.post('/api/fields/create',passport.authenticate('jwt', {session: false}), upload.array('image', 2), FieldsController.create);

}