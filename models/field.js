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
            'adress', r.name,
            'street1', r.image,
            'street2', r.route,
            'latitude', r.latitude,
            'longitude', r.longitude
        )
    ) AS address
from
	fields as F
INNER JOIN
	categories  as C
on
	F.id_category = C.id

    INNER JOIN
	adress as r
on
	r.id_field = F.id 
where 
	c.id = $1
    
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
            created_at,
            updated_at
        )
    VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING id
    `
    return db.oneOrNone(sql, [
        field.name,
        field.description,
        field.image1,
        field.image2,
        field.id_category,
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