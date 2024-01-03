// To parse this JSON data, do
//
//     final revisionModel = revisionModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

RevisionModel revisionModelFromJson(String str) => RevisionModel.fromJson(json.decode(str));

String revisionModelToJson(RevisionModel data) => json.encode(data.toJson());

class RevisionModel {
  List<RevisionResult> data;

  RevisionModel({
    required this.data,
  });

  factory RevisionModel.fromJson(Map<String, dynamic> json) => RevisionModel(
    data: List<RevisionResult>.from(json["data"].map((x) => RevisionResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RevisionResult {
  int id;
  DateTime sana;
  String ndoc;
  String izoh;
  num sm;
  num smS;
  int idHodim;
  int pr;
  String yil;
  String oy;
  int idSkl;
  String vaqt;
  num f1;
  num f2;
  num nSm;
  num nSmS;
  int st;
  List<SklRevTov> sklRevTov;

  RevisionResult({
    required this.id,
    required this.sana,
    required this.ndoc,
    required this.izoh,
    required this.sm,
    required this.smS,
    required this.idHodim,
    required this.pr,
    required this.yil,
    required this.oy,
    required this.idSkl,
    required this.vaqt,
    required this.f1,
    required this.f2,
    required this.nSm,
    required this.nSmS,
    required this.st,
    required this.sklRevTov,
  });

  factory RevisionResult.fromJson(Map<String, dynamic> json) => RevisionResult(
    id: json["ID"]??0,
    sana: json["SANA"] ==null?DateTime.now():DateTime.parse(json["SANA"]),
    ndoc: json["NDOC"]??"",
    izoh: json["IZOH"]??"",
    sm: json["SM"]??0.0,
    smS: json["SM_S"]??0.0,
    idHodim: json["ID_HODIM"]??0,
    pr: json["PR"]??0,
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    idSkl: json["ID_SKL"]??0,
    vaqt: json["VAQT"],
    f1: json["F1"]??0.0,
    f2: json["F2"]??0.0,
    nSm: json["N_SM"]??0.0,
    nSmS: json["N_SM_S"]??0.0,
    st: json["ST"]??0,
    sklRevTov: json["skl_rev_tov"] == null?<SklRevTov>[]:List<SklRevTov>.from(json["skl_rev_tov"].map((x) => SklRevTov.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SANA": "${sana.year.toString().padLeft(4, '0')}-${sana.month.toString().padLeft(2, '0')}-${sana.day.toString().padLeft(2, '0')}",
    "NDOC": ndoc,
    "IZOH": izoh,
    "SM": sm,
    "SM_S": smS,
    "ID_HODIM": idHodim,
    "PR": pr,
    "YIL": yil,
    "OY": oy,
    "ID_SKL": idSkl,
    "VAQT": DateFormat.Hms().format(DateTime.now()),
    "F1": f1,
    "F2": f2,
    "N_SM": nSm,
    "N_SM_S": nSmS,
    "ST": st,
    "SKL_REV_TOV": List<dynamic>.from(sklRevTov.map((x) => x.toJson())),
  };
}

class SklRevTov {
  int id;
  String name;
  int idSkl2;
  num soni;
  num nSoni;
  num fSoni;
  num narhi;
  num narhiS;
  int snarhi;
  num snarhiS;
  int snarhi1;
  num snarhi1S;
  int snarhi2;
  num snarhi2S;

  SklRevTov({
    required this.id,
    required this.name,
    required this.idSkl2,
    required this.soni,
    required this.nSoni,
    required this.fSoni,
    required this.narhi,
    required this.narhiS,
    required this.snarhi,
    required this.snarhiS,
    required this.snarhi1,
    required this.snarhi1S,
    required this.snarhi2,
    required this.snarhi2S,
  });

  factory SklRevTov.fromJson(Map<String, dynamic> json) => SklRevTov(
    id: json["ID"]??0,
    name: json["NAME"]??'',
    idSkl2: json["ID_SKL2"]??0,
    soni: json["SONI"]??0.0,
    nSoni: json["N_SONI"]??0.0,
    fSoni: json["F_SONI"]??0.0,
    narhi: json["NARHI"]??0.0,
    narhiS: json["NARHI_S"]??0.0,
    snarhi: json["SNARHI"]??0.0,
    snarhiS: json["SNARHI_S"]??0.0,
    snarhi1: json["SNARHI1"],
    snarhi1S: json["SNARHI1_S"]??0.0,
    snarhi2: json["SNARHI2"]??0,
    snarhi2S: json["SNARHI2_S"]??0.0,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "ID_SKL2": idSkl2,
    "SONI": soni,
    "N_SONI": nSoni,
    "F_SONI": fSoni,
    "NARHI": narhi,
    "NARHI_S": narhiS,
    "SNARHI": snarhi,
    "SNARHI_S": snarhiS,
    "SNARHI1": snarhi1,
    "SNARHI1_S": snarhi1S,
    "SNARHI2": snarhi2,
    "SNARHI2_S": snarhi2S,
  };
}
