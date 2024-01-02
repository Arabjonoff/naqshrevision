import 'dart:convert';

BaseListModel baseListModelFromJson(String str) => BaseListModel.fromJson(json.decode(str));

String baseListModelToJson(BaseListModel data) => json.encode(data.toJson());

class BaseListModel {
  List<BaseListResult> data;

  BaseListModel({
    required this.data,
  });

  factory BaseListModel.fromJson(Map<String, dynamic> json) => BaseListModel(
    data: List<BaseListResult>.from(json["data"].map((x) => BaseListResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<BaseListResult>.from(data.map((x) => x.toJson())),
  };
}

class BaseListResult {
  int id;
  String name;
  int idSkl2;
  int idTip;
  num idFirma;
  num idEdiz;
  num narhi;
  num narhiS;
  num snarhi;  /// 1
  num snarhiS; /// 1
  num snarhi1; /// 2
  num snarhi1S;/// 2
  num snarhi2; /// 3
  num snarhi2S;/// 3
  num ksoni;
  num ksm;
  num ksmS;
  num psoni;
  num psm;
  num psmS;
  num rsoni;
  num rsm;
  num rsmS;
  num hsoni;
  num hsm;
  num hsmS;
  num vsoni;
  num vsm;
  num vsmS;
  num vzsoni;
  num vzsm;
  num vzsmS;
  num psksoni;
  num psksm;
  num psksmS;
  num rsksoni;
  num rsksm;
  num rsksmS;
  num osoni;
  num osm;
  num osmS;
  num osmT;
  num osmTS;
  num ksmT;
  num ksmTS;
  String yil;
  String oy;
  num idSkl0;
  num foyda;
  num foydaS;
  num soni;
  dynamic vz;
  String photo;

  BaseListResult({
    required this.id,
    required this.name,
    required this.idSkl2,
    required this.idTip,
    required this.idFirma,
    required this.idEdiz,
    required this.narhi,
    required this.narhiS,
    required this.snarhi,
    required this.snarhiS,
    required this.snarhi1,
    required this.snarhi1S,
    required this.snarhi2,
    required this.snarhi2S,
    required this.ksoni,
    required this.ksm,
    required this.ksmS,
    required this.psoni,
    required this.psm,
    required this.psmS,
    required this.rsoni,
    required this.rsm,
    required this.rsmS,
    required this.hsoni,
    required this.hsm,
    required this.hsmS,
    required this.vsoni,
    required this.vsm,
    required this.vsmS,
    required this.vzsoni,
    required this.vzsm,
    required this.vzsmS,
    required this.psksoni,
    required this.psksm,
    required this.psksmS,
    required this.rsksoni,
    required this.rsksm,
    required this.rsksmS,
    required this.osoni,
    required this.osm,
    required this.osmS,
    required this.osmT,
    required this.osmTS,
    required this.ksmT,
    required this.ksmTS,
    required this.yil,
    required this.oy,
    required this.idSkl0,
    required this.foyda,
    required this.foydaS,
    required this.soni,
    required this.vz,
    required this.photo,
  });

  factory BaseListResult.fromJson(Map<String, dynamic> json) => BaseListResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idSkl2: json["ID_SKL2"]??0,
    idTip: json["ID_TIP"]??0,
    idFirma: json["ID_FIRMA"]??0,
    idEdiz: json["ID_EDIZ"]??0,
    narhi: json["NARHI"]??0,
    narhiS: json["NARHI_S"]??0,
    snarhi: json["SNARHI"]??0,
    snarhiS: json["SNARHI_S"]??0,
    snarhi1: json["SNARHI1"]??0.0,
    snarhi1S: json["SNARHI1_S"]??0.0,
    snarhi2: json["SNARHI2"]??0.0,
    snarhi2S: json["SNARHI2_S"]??0.0,
    ksoni: json["KSONI"]??0.0,
    ksm: json["KSM"]??0.0,
    ksmS: json["KSM_S"]??0.0,
    psoni: json["PSONI"]??0,
    psm: json["PSM"]??0,
    psmS: json["PSM_S"]??0.0,
    rsoni: json["RSONI"]??0.0,
    rsm: json["RSM"]??0,
    rsmS: json["RSM_S"]??0.0,
    hsoni: json["HSONI"]??0.0,
    hsm: json["HSM"]??0,
    hsmS: json["HSM_S"]??0.0,
    vsoni: json["VSONI"]??0,
    vsm: json["VSM"]??0,
    vsmS: json["VSM_S"]??0,
    vzsoni: json["VZSONI"]??0,
    vzsm: json["VZSM"]??0,
    vzsmS: json["VZSM_S"]??0,
    psksoni: json["PSKSONI"]??0,
    psksm: json["PSKSM"]??0,
    psksmS: json["PSKSM_S"]??0,
    rsksoni: json["RSKSONI"]??0,
    rsksm: json["RSKSM"]??0,
    rsksmS: json["RSKSM_S"]??0,
    osoni: json["OSONI"]??0,
    osm: json["OSM"]??0,
    osmS: json["OSM_S"]??0,
    osmT: json["OSM_T"]??0,
    osmTS: json["OSM_T_S"]??0,
    ksmT: json["KSM_T"]??0,
    ksmTS: json["KSM_T_S"]??0,
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    idSkl0: json["ID_SKL0"]??0,
    foyda: json["FOYDA"]??0,
    foydaS: json["FOYDA_S"]??0,
    soni: json["SONI"]??0,
    vz: json["VZ"]??0,
    photo: json["PHOTO"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "idSkl2": idSkl2,
    "idTip": idTip,
    "idFirma": idFirma,
    "idEdiz": idEdiz,
    "narhi": narhi,
    "narhiS": narhiS,
    "snarhi": snarhi,
    "snarhiS": snarhiS,
    "snarhi1": snarhi1,
    "snarhi1S": snarhi1S,
    "snarhi2": snarhi2,
    "snarhi2S": snarhi2S,
    "ksoni": ksoni,
    "ksm": ksm,
    "ksmS": ksmS,
    "psoni": psoni,
    "psm": psm,
    "psmS": psmS,
    "rsoni": rsoni,
    "rsm": rsm,
    "rsmS": rsmS,
    "hsoni": hsoni,
    "hsm": hsm,
    "hsmS": hsmS,
    "vsoni": vsoni,
    "vsm": vsm,
    "vsmS": vsmS,
    "vzsoni": vzsoni,
    "vzsm": vzsm,
    "vzsmS": vzsmS,
    "psksoni": psksoni,
    "psksm": psksm,
    "psksmS": psksmS,
    "rsksoni": rsksoni,
    "rsksm": rsksm,
    "rsksmS": rsksmS,
    "osoni": osoni,
    "osm": osm,
    "osmS": osmS,
    "osmT": osmT,
    "osmTS": osmTS,
    "ksmT": ksmT,
    "ksmTS": ksmTS,
    "yil": yil,
    "oy": oy,
    "idSkl0": idSkl0,
    "foyda": foyda,
    "foydaS": foydaS,
    "soni": soni,
    "vz": vz,
    "photo": photo,
  };
}
