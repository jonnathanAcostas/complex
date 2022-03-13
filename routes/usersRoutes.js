const UserControllers = require('../controllers/usersControllers');
const passport = require('passport');
module.exports = (app, upload) =>{

    //TRAER DATOS
    app.get('/api/users/getAll', UserControllers.getAll);
    
    app.get('/api/users/findById/:id', passport.authenticate('jwt', {session: false}), UserControllers.findById);


    //GUARDAR DATOS
    app.post('/api/users/create', upload.array('image', 1), UserControllers.registerWithImage);
    app.post('/api/users/login', UserControllers.login);
    app.post('/api/users/logout', UserControllers.logout);

    //ACTUALIZAR DATOS

    app.put('/api/users/update',passport.authenticate('jwt', {session: false}), upload.array('image', 1), UserControllers.update);

}
