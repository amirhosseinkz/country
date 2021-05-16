// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(json.decode(str).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final String tableCountry = 'country';

class CountryFields {

  static final List<String> values = [
    id , name , countryId
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String countryId = '_countryId';

}


class CountryModel {
  CountryModel({

    this.id,
    this.countryId,
    this.name,
  });

  int id;
  int countryId;
  String name;

  CountryModel copy({
    int id,
    int countryId,
    String name,
}) =>
  CountryModel(
    id:  id ?? this.id,
    name: name ?? this.name,
    countryId: countryId ?? this.countryId
  );

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id: json["id"],
    countryId: json["country_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "name": name,
  };



}
