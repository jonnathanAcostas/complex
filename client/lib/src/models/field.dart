import 'dart:convert';

import 'package:client/src/models/adress.dart';

Field fieldFromJson(String str) => Field.fromJson(json.decode(str));

String fieldToJson(Field data) => json.encode(data.toJson());

class Field {
  String id;
  String name;
  String description;
  String image1;
  String image2;
  String idCategory;
  String idAdress;
  int quantity;
  List<Adress> adress = [];

  List<Field> toList = [];

  Field(
      {this.id,
      this.name,
      this.description,
      this.image1,
      this.image2,
      this.idCategory,
      this.adress});

  factory Field.fromJson(Map<String, dynamic> json) => Field(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image1: json["image1"],
      image2: json["image2"],
      idCategory: json["id_category"],
      adress: json["adress"] == null
          ? []
          : List<Adress>.from(
                  json['adress'].map((model) => Adress.fromJson(model))) ??
              []);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "id_category": idCategory,
        "adress": adress,
      };

  Field.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Field field = Field.fromJson(item);
      toList.add(field);
    });
  }
}
