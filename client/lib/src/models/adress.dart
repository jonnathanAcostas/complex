import 'dart:convert';

import 'package:client/src/models/field.dart';

Adress adressFromJson(String str) => Adress.fromJson(json.decode(str));

String adressToJson(Adress data) => json.encode(data.toJson());

class Adress {
  String id;
  String adress;
  String street1;
  String street2;
  double latitude;
  double longitude;
  List<Adress> toList = [];

  Adress({
    this.id,
    this.adress,
    this.street1,
    this.street2,
    this.latitude,
    this.longitude,
  });

  Adress.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Adress adress = Adress.fromJson(item);
      toList.add(adress);
    });
  }

  factory Adress.fromJson(Map<String, dynamic> json) => Adress(
        id: json["id"] is int ? json['id'].toString() : json["id"],
        adress: json["adress"],
        street1: json["street1"],
        street2: json["street2"],
        latitude: json["latitude"] is String
            ? double.parse(json["latitude"])
            : json["latitude"],
        longitude: json["longitude"] is String
            ? double.parse(json["longitude"])
            : json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adress": adress,
        "street1": street1,
        "street2": street2,
        "latitude": latitude,
        "longitude": longitude,
      };
}
