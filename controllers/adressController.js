const Adress = require('../models/adress');

module.exports = {

    async getAllAdress(req, res, next) {

        try{

            const data = await Adress.getAllAdress();
            console.log(`Adress ${JSON.stringify (data)}`);
            return res.status(201).json(data);

        }catch(error){
            console.error(`Error ${error}`);
            return res.status(501).json({
                message: 'Error al momento de traer direcciones',
                error: error,
                success: false
            
            
            })
        }

    },


    async create(req, res, next) {

        try {
            const adress = req.body;
            const data = await Adress.create(adress);
            return res.status(201).json({
                success: true,
                message: 'Dirección creada',
               data: data.id
            })

        }catch(error) {
            console.log(`Error ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Error creando dirección',
                error: error
            })
        }
    }


}