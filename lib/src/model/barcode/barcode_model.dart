// To parse this JSON data, do
//
//     final barCodeModel = barCodeModelFromJson(jsonString);

import 'dart:convert';

BarCodeModel barCodeModelFromJson(String str) => BarCodeModel.fromJson(json.decode(str));

String barCodeModelToJson(BarCodeModel data) => json.encode(data.toJson());

class BarCodeModel {
  bool status;
  List<BarcodeResult> data;

  BarCodeModel({
    required this.status,
    required this.data,
  });

  factory BarCodeModel.fromJson(Map<String, dynamic> json) => BarCodeModel(
    status: json["status"],
    data: List<BarcodeResult>.from(json["data"].map((x) => BarcodeResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BarcodeResult {
  int id;
  String name;
  String shtr;
  int idSkl2;
  dynamic vaqt;

  BarcodeResult({
    required this.id,
    required this.name,
    required this.shtr,
    required this.idSkl2,
    required this.vaqt,
  });

  factory BarcodeResult.fromJson(Map<String, dynamic> json) => BarcodeResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    shtr: json["SHTR"]??"",
    idSkl2: json["ID_SKL2"]??0,
    vaqt: json["VAQT"] == null?DateTime.now():DateTime.parse(json["VAQT"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "SHTR": shtr,
    "ID_SKL2": idSkl2,
    "VAQT": vaqt.toString(),
  };
}
