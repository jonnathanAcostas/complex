const Category = require('../models/category');

module.exports = {


    async getAll(req, res, next) {

        try{

            const data = await Category.getAll();
            console.log(`Categorias ${JSON.stringify (data)}`);
            return res.status(201).json(data);

        }catch(error){
            console.error(`Error ${error}`);
            return res.status(501).json({
                message: 'Error al momento de traer categorias',
                error: error,
                success: false
            
            
            })
        }

    },


    async create(req, res, next) {

    try {

        const category = req.body;
        console.log(`Categoria enviada: ${category}`);

        const data = await Category.create(category);

        return res.status(201).json({
            message: 'Categoria creada',
            success: true,
            data: data.id
        })
    }
    catch(error) {

        console.log(`Error : ${error}`);
        return res.status(501).json({
            message: ' error al crear categoria',
            success: false,
            error: error
        })
    }


    }
}