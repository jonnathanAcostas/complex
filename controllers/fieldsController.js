const Field = require('../models/field');
const storage = require('../utils/cloud_storage');
const asyncForEach = require('../utils/async_foreach');

module.exports ={

    async create(req, res, next) {

        let field = JSON.parse(req.body.field);
        console.log(`field ${JSON.stringify(field)}`);
        
        const files = req.files;

        let inserts = 0;

        if(files.length === 0) {
            return res.status(501).json({
                message: 'Error al registrar la cancha sin imagen',
                success:false
            })
        }
        else{
            try {

                const data = await Field.create(field); // Almacenando info de cancha
                field.id = data.id;

                const start = async ()=> {
                    await asyncForEach(files, async(flie) => {
                    const pathImage= `image_${Date.now()}`;
                    const url = await storage(files, pathImage);

                    if(url !== undefined && url !== null){
                        if (inserts == 0){ //IMAGEN 1
                            field.image1 = url;

                        }
                        else if( inserts == 1){ //IMAGEN 2
                            field.image2 = url;
                        }
                        else if( inserts == 2){ //IMAGEN 3
                            field.image3 = url;
                        }
                    }

                    await Field.update(field);
                    inserts = inserts + 1;

                    if(inserts == files.length){
                        return res.status(201).json({
                            success: true,
                            message: 'Cancha registrada correctamente' 
                        });
                    }

                    });
                }

            start();

            }catch(error){
                console.log(`Error: ${error}`);
                return res.status(501).json({
                    message: `Error al registrar cancha ${error}`,
                    success:false,
                    error: error
                });
            }


        }

    }

}
