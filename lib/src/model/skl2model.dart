// To parse this JSON data, do
//
//     final skl2BaseModel = skl2BaseModelFromJson(jsonString);

import 'dart:convert';

Skl2BaseModel skl2BaseModelFromJson(String str) => Skl2BaseModel.fromJson(json.decode(str));


class Skl2BaseModel {
  bool status;
  List<Skl2Result> data;

  Skl2BaseModel({
    required this.status,
    required this.data,
  });

  factory Skl2BaseModel.fromJson(Map<String, dynamic> json) => Skl2BaseModel(
    status: json["status"],
    data: List<Skl2Result>.from(json["data"].map((x) => Skl2Result.fromJson(x))),
  );

}

class Skl2Result {
  int id;
  String name;
  int idTip;
  int idFirma;
  String photo;
  Skl2Result({
    required this.id,
    required this.name,
    required this.idTip,
    required this.idFirma,
    required this.photo,
  });

  factory Skl2Result.fromJson(Map<String, dynamic> json) => Skl2Result(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idTip: json["ID_TIP"]??0,
    idFirma: json["ID_FIRMA"]??0,
    photo: json["PHOTO"]??"",
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "ID_TIP": idTip,
    "ID_FIRMA": idFirma,
    "PHOTO": photo,
  };
}
