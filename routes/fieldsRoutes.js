const FieldsController = require('../controllers/fieldsController');
const passport = require('passport');

module.exports =(app, upload) => {

app.post('/api/fields/create',passport.authenticate('jwt', {session: false}), upload.array('image', 2), FieldsController.create);

}