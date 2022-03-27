const db = require('../config/config');

const Field = {};


Field.findByCategory = (id_category) => {
    const sql = `
    SELECT	
	F.id,
	F.name,
	F.description,
	F.image1,
	F.image2,
	F.id_category,
    json_agg(
        json_build_object(
            'id', r.id,
            'adress', r.adress,
            'street1', r.street1,
            'street2', r.street2,
            'latitude', r.latitude,
            'longitude', r.longitude
        )
    ) AS adress
from fields as F
INNER join 	categories  as C on F.id_category = C.id
INNER JOIN	adress as r on 	F.id_adress =r.id
GROUP by F.id;
    
    `;

    return db.manyOrNone(sql);
}

Field.findByCategoryField = (id_category) =>{
    const sql = `
    SELECT 
	f.id,
	f.name,
	f.description,
	f.image1,
	f.image2,
	f.id_category,
    json_agg(
        json_build_object(
            'id', r.id,
            'adress', r.adress,
            'street1', r.street1,
            'street2', r.street2,
            'latitude', r.latitude,
            'longitude', r.longitude
        )
    ) AS adress
FROM
	fields as f
INNER JOIN
	categories as c
ON
	f.id_category = c.id
INNER JOIN
	adress as r on 	f.id_adress =r.id

WHERE 
	c.id = $1
GROUP BY 
	f.id
    `;
    return db.manyOrNone(sql, id_category);
}


Field.create = (field) => {
    const sql = `
    INSERT INTO
        fields(
            name,
            description,
            image1,
            image2,
            id_category,
            id_adress,
            created_at,
            updated_at
        )
    VALUES($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id
    `
    return db.oneOrNone(sql, [
        field.name,
        field.description,
        field.image1,
        field.image2,
        field.id_category,
        field.adress,
        new Date(),
        new Date()
    ]);
}

Field.update = (field) => {
    const sql = `
    UPDATE
        fields
    SET
        name = $2,
        description = $3,
        image1 = $4,
        image2 = $5,
        id_category = $6,
        updated_at = $7
    WHERE 
        id = $1
    `;
    return db.none(sql, [
        field.id,
        field.name,
        field.description,
        field.image1,
        field.image2,
        field.id_category,
        new Date()
    ]);
}

module.exports = Field