const db = require('../config/config');

const Field = {};

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