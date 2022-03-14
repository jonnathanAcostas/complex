const db = require('../config/config');

const Adress = {};


Adress.getAll = () => {
    const sql = `
    SELECT
        id,
        adress,
        street1,
        street2,
        latitude,
        longitude
    FROM
        adress
    `;
    return db.oneOrNone(sql);
}


Adress.create = (adress)=>{
    const sql =`
    INSERT INTO
        adress(
            adress,
            street1,
            street2,
            latitude,
            longitude,
            created_at,
            updated_at
       )
    VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id
    `;

    return db.oneOrNone(sql,[
        adress.adress,
        adress.street1,
        adress.street2,
        adress.latitude,
        adress.longitude,
        new Date(),
        new Date()



    ])
}




module.exports = Adress;