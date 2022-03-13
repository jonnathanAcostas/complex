import 'dart:convert';

Field fieldFromJson(String str) => Field.fromJson(json.decode(str));

String fieldToJson(Field data) => json.encode(data.toJson());

class Field {
  String id;
    String name;
    String description;
    String image1;
    String image2;
    int idCategory;
    int quantity;


    Field({
        this.id,
        this.name,
        this.description,
        this.image1,
        this.image2,
        this.idCategory,
        this.quantity,
    });

    

    factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        idCategory: json["id_category"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "id_category": idCategory,
        "quantity": quantity,
    };
}