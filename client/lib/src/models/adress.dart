import 'dart:convert';

import 'package:client/src/models/field.dart';

Adress adressFromJson(String str) => Adress.fromJson(json.decode(str));

String adressToJson(Adress data) => json.encode(data.toJson());

class Adress {


    String id;
    String adress;
    String street1;
    String street2;
    String reference;
    double latitude;
    double longitude;
    int idField;


    Adress({
        this.id,
        this.adress,
        this.street1,
        this.street2,
        this.reference,
        this.latitude,
        this.longitude,
        this.idField,
    });

  


    factory Adress.fromJson(Map<String, dynamic> json) => Adress(
        id: json["id"],
        adress: json["adress"],
        street1: json["street1"],
        street2: json["street2"],
        reference: json["reference"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        idField: json["id_field"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "adress": adress,
        "street1": street1,
        "street2": street2,
        "reference": reference,
        "latitude": latitude,
        "longitude": longitude,
        "id_field": idField,
    };
}