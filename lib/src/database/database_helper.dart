import 'package:naqshrevision/src/model/barcode/barcode_model.dart';
import 'package:naqshrevision/src/model/baselist_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'db_column.dart';

class DataBaseHelper{
  static final DataBaseHelper baseHelper = DataBaseHelper.internal();

  factory DataBaseHelper() => baseHelper;
  static Database? _db;

  DataBaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  _initDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'revisonbase');
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return await db;
  }

  void _onCreate(Database database, int version) async{
    await database.execute('CREATE TABLE product('
        '${ProductColumnName.id} INTEGER NOT NULL,'
        '${ProductColumnName.name} TEXT,'
        '${ProductColumnName.idSkl2} INTEGER,'
        '${ProductColumnName.idTip} INTEGER,'
        '${ProductColumnName.idFirma} REAL,'
        '${ProductColumnName.idEdiz} REAL,'
        '${ProductColumnName.narhi} REAL,'
        '${ProductColumnName.narhiS} REAL,'
        '${ProductColumnName.snarhi} REAL,'
        '${ProductColumnName.snarhiS} REAL,'
        '${ProductColumnName.snarhi1} REAL,'
        '${ProductColumnName.snarhi1S} REAL,'
        '${ProductColumnName.snarhi2} REAL,'
        '${ProductColumnName.snarhi2S} REAL,'
        '${ProductColumnName.ksoni} REAL,'
        '${ProductColumnName.ksm} REAL,'
        '${ProductColumnName.ksmS} REAL,'
        '${ProductColumnName.psoni} REAL,'
        '${ProductColumnName.psm} REAL,'
        '${ProductColumnName.psmS} REAL,'
        '${ProductColumnName.rsoni} REAL,'
        '${ProductColumnName.rsm} REAL,'
        '${ProductColumnName.rsmS} REAL,'
        '${ProductColumnName.hsoni} REAL,'
        '${ProductColumnName.hsm} REAL,'
        '${ProductColumnName.hsmS} REAL,'
        '${ProductColumnName.vsoni} REAL,'
        '${ProductColumnName.vsm} REAL,'
        '${ProductColumnName.vsmS} REAL,'
        '${ProductColumnName.vzsoni} REAL,'
        '${ProductColumnName.vzsm} REAL,'
        '${ProductColumnName.vzsmS} REAL,'
        '${ProductColumnName.psksoni} REAL,'
        '${ProductColumnName.psksm} REAL,'
        '${ProductColumnName.psksmS} REAL,'
        '${ProductColumnName.rsksoni} REAL,'
        '${ProductColumnName.rsksm} REAL,'
        '${ProductColumnName.rsksmS} REAL,'
        '${ProductColumnName.osoni} REAL,'
        '${ProductColumnName.osm} REAL,'
        '${ProductColumnName.osmS} REAL,'
        '${ProductColumnName.osmT} REAL,'
        '${ProductColumnName.osmTS} REAL,'
        '${ProductColumnName.ksmT} REAL,'
        '${ProductColumnName.ksmTS} REAL,'
        '${ProductColumnName.yil} TEXT,'
        '${ProductColumnName.oy} TEXT,'
        '${ProductColumnName.idSkl0} REAL,'
        '${ProductColumnName.foyda} REAL,'
        '${ProductColumnName.foydaS} REAL,'
        '${ProductColumnName.soni} REAL,'
        '${ProductColumnName.vz} TEXT,'
        '${ProductColumnName.photo} TEXT'
        ')');

    await database.execute('CREATE TABLE barcode('
        'ID INTEGER,'
        'NAME TEXT,'
        'SHTR TEXT,'
        'VAQT TEXT,'
        'ID_SKL2 INTEGER'
        ')');

    await database.execute('CREATE TABLE cart('
        '${ProductColumnName.id} INTEGER NOT NULL,'
        '${ProductColumnName.name} TEXT,'
        '${ProductColumnName.idSkl2} INTEGER,'
        '${ProductColumnName.idTip} INTEGER,'
        '${ProductColumnName.idFirma} REAL,'
        '${ProductColumnName.idEdiz} REAL,'
        '${ProductColumnName.narhi} REAL,'
        '${ProductColumnName.narhiS} REAL,'
        '${ProductColumnName.snarhi} REAL,'
        '${ProductColumnName.snarhiS} REAL,'
        '${ProductColumnName.snarhi1} REAL,'
        '${ProductColumnName.snarhi1S} REAL,'
        '${ProductColumnName.snarhi2} REAL,'
        '${ProductColumnName.snarhi2S} REAL,'
        '${ProductColumnName.ksoni} REAL,'
        '${ProductColumnName.ksm} REAL,'
        '${ProductColumnName.ksmS} REAL,'
        '${ProductColumnName.psoni} REAL,'
        '${ProductColumnName.psm} REAL,'
        '${ProductColumnName.psmS} REAL,'
        '${ProductColumnName.rsoni} REAL,'
        '${ProductColumnName.rsm} REAL,'
        '${ProductColumnName.rsmS} REAL,'
        '${ProductColumnName.hsoni} REAL,'
        '${ProductColumnName.hsm} REAL,'
        '${ProductColumnName.hsmS} REAL,'
        '${ProductColumnName.vsoni} REAL,'
        '${ProductColumnName.vsm} REAL,'
        '${ProductColumnName.vsmS} REAL,'
        '${ProductColumnName.vzsoni} REAL,'
        '${ProductColumnName.vzsm} REAL,'
        '${ProductColumnName.vzsmS} REAL,'
        '${ProductColumnName.psksoni} REAL,'
        '${ProductColumnName.psksm} REAL,'
        '${ProductColumnName.psksmS} REAL,'
        '${ProductColumnName.rsksoni} REAL,'
        '${ProductColumnName.rsksm} REAL,'
        '${ProductColumnName.rsksmS} REAL,'
        '${ProductColumnName.osoni} REAL,'
        '${ProductColumnName.osm} REAL,'
        '${ProductColumnName.osmS} REAL,'
        '${ProductColumnName.osmT} REAL,'
        '${ProductColumnName.osmTS} REAL,'
        '${ProductColumnName.ksmT} REAL,'
        '${ProductColumnName.ksmTS} REAL,'
        '${ProductColumnName.yil} TEXT,'
        '${ProductColumnName.oy} TEXT,'
        '${ProductColumnName.idSkl0} REAL,'
        '${ProductColumnName.foyda} REAL,'
        '${ProductColumnName.foydaS} REAL,'
        '${ProductColumnName.soni} REAL,'
        '${ProductColumnName.vz} TEXT,'
        '${ProductColumnName.photo} TEXT'
        ')');
  }
  /// Insert Product
  Future<int> saveProduct(BaseListResult item) async {
    var dbClient = await db;
    var result = dbClient.insert('product', item.toJson());
    print(await result);
    return result;
  }

  /// Insert Cart
  Future<int> saveCart(BaseListResult item) async {
    var dbClient = await db;
    var result = dbClient.insert('cart', item.toJson());
    print(await result);
    return result;
  }

  /// Insert Barcode
  Future<int> saveBarCode(BarcodeResult item) async {
    var dbClient = await db;
    var result = dbClient.insert('barcode', item.toJson());
    return result;
  }

  /// Update Product
  Future<int> updateProduct(BaseListResult item) async {
    var dbClient = await db;
    var result = await dbClient.update('product', item.toJson(),
        where: 'id = ?', whereArgs: [item.id]);
    return result;
  }

  /// Update Cart
  Future<int> updateCart(BaseListResult item) async {
    var dbClient = await db;
    var result = await dbClient.update('cart', item.toJson(),
        where: 'id = ?', whereArgs: [item.id]);
    return result;
  }

  /// Get Product
  Future<List<BaseListResult>> getDataBaseList(String obj) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM product WHERE name LIKE '%$obj%' ");
    List<BaseListResult> data = <BaseListResult>[];
    for (int i = 0; i < list.length; i++) {
      BaseListResult baseListResult = BaseListResult(
        id: list[i]['id'],
        name: list[i]['name'],
        idSkl2: list[i]['idSkl2'],
        idTip: list[i]['idTip'],
        idFirma: list[i]['idFirma'],
        idEdiz: list[i]['idEdiz'],
        narhi: list[i]['narhi'],
        narhiS: list[i]['narhiS'],
        snarhi: list[i]['snarhi'],
        snarhiS: list[i]['snarhiS'],
        snarhi1: list[i]['snarhi1'],
        snarhi1S: list[i]['snarhi1S'],
        snarhi2: list[i]['snarhi2'],
        snarhi2S: list[i]['snarhi2S'],
        ksoni: list[i]['ksoni'],
        ksm: list[i]['ksm'],
        ksmS: list[i]['ksmS'],
        psoni: list[i]['psoni'],
        psm: list[i]['psm'],
        psmS: list[i]['psmS'],
        rsoni: list[i]['rsoni'],
        rsm: list[i]['rsm'],
        rsmS: list[i]['rsmS'],
        hsoni: list[i]['hsoni'],
        hsm: list[i]['hsm'],
        hsmS: list[i]['hsmS'],
        vsoni: list[i]['vsoni'],
        vsm: list[i]['vsm'],
        vsmS: list[i]['vsmS'],
        vzsoni: list[i]['vzsoni'],
        vzsm: list[i]['vzsm'],
        vzsmS: list[i]['vzsmS'],
        psksoni: list[i]['psksoni'],
        psksm: list[i]['psksm'],
        psksmS: list[i]['psksmS'],
        rsksoni: list[i]['rsksoni'],
        rsksm: list[i]['rsksm'],
        rsksmS: list[i]['rsksmS'],
        osoni: list[i]['osoni'],
        osm: list[i]['osm'],
        osmS: list[i]['osmS'],
        osmT: list[i]['osmT'],
        osmTS: list[i]['osmTS'],
        ksmT: list[i]['ksmT'],
        ksmTS: list[i]['ksmTS'],
        yil: list[i]['yil'],
        oy: list[i]['oy'],
        idSkl0: list[i]['idSkl0'],
        foyda: list[i]['foyda'],
        foydaS: list[i]['foydaS'],
        soni: list[i]['soni'],
        vz: list[i]['vz'],
        photo: list[i]['photo'],
      );
      data.add(baseListResult);
    }
    return data;
  }

  /// Get Cart
  Future<List<BaseListResult>> getCartList() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM cart");
    List<BaseListResult> data = <BaseListResult>[];
    for (int i = 0; i < list.length; i++) {
      BaseListResult baseListResult = BaseListResult(
        id: list[i]['id'],
        name: list[i]['name'],
        idSkl2: list[i]['idSkl2'],
        idTip: list[i]['idTip'],
        idFirma: list[i]['idFirma'],
        idEdiz: list[i]['idEdiz'],
        narhi: list[i]['narhi'],
        narhiS: list[i]['narhiS'],
        snarhi: list[i]['snarhi'],
        snarhiS: list[i]['snarhiS'],
        snarhi1: list[i]['snarhi1'],
        snarhi1S: list[i]['snarhi1S'],
        snarhi2: list[i]['snarhi2'],
        snarhi2S: list[i]['snarhi2S'],
        ksoni: list[i]['ksoni'],
        ksm: list[i]['ksm'],
        ksmS: list[i]['ksmS'],
        psoni: list[i]['psoni'],
        psm: list[i]['psm'],
        psmS: list[i]['psmS'],
        rsoni: list[i]['rsoni'],
        rsm: list[i]['rsm'],
        rsmS: list[i]['rsmS'],
        hsoni: list[i]['hsoni'],
        hsm: list[i]['hsm'],
        hsmS: list[i]['hsmS'],
        vsoni: list[i]['vsoni'],
        vsm: list[i]['vsm'],
        vsmS: list[i]['vsmS'],
        vzsoni: list[i]['vzsoni'],
        vzsm: list[i]['vzsm'],
        vzsmS: list[i]['vzsmS'],
        psksoni: list[i]['psksoni'],
        psksm: list[i]['psksm'],
        psksmS: list[i]['psksmS'],
        rsksoni: list[i]['rsksoni'],
        rsksm: list[i]['rsksm'],
        rsksmS: list[i]['rsksmS'],
        osoni: list[i]['osoni'],
        osm: list[i]['osm'],
        osmS: list[i]['osmS'],
        osmT: list[i]['osmT'],
        osmTS: list[i]['osmTS'],
        ksmT: list[i]['ksmT'],
        ksmTS: list[i]['ksmTS'],
        yil: list[i]['yil'],
        oy: list[i]['oy'],
        idSkl0: list[i]['idSkl0'],
        foyda: list[i]['foyda'],
        foydaS: list[i]['foydaS'],
        soni: list[i]['soni'],
        vz: list[i]['vz'],
        photo: list[i]['photo'],
      );
      data.add(baseListResult);
    }
    return data;
  }

  /// Get Barcode
  Future<List<BarcodeResult>> getBarcode() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM barcode');
    List<BarcodeResult> data = <BarcodeResult>[];
    for (int i = 0; i < list.length; i++) {
      BarcodeResult barcodeResult = BarcodeResult(
        id: list[i]["ID"],
        name: list[i]["NAME"],
        shtr: list[i]["SHTR"],
        idSkl2: list[i]["ID_SKL2"],
        vaqt: list[i]["VAQT"],
      );
      data.add(barcodeResult);
    }
    return data;
  }


  /// Clear Product
  Future<void> clearProduct() async {
    var dbClient = await db;
    await dbClient.rawQuery('DELETE FROM product');
  }

  /// Clear Barcode
  Future<void> clearBarcode() async {
    var dbClient = await db;
    await dbClient.rawQuery("DELETE FROM barcode");
  }

  /// Delete Cart
  Future<int> deleteCart(BaseListResult item) async {
    var dbClient = await db;
    var result = await dbClient.delete('cart', where: 'id = ?', whereArgs: [item.id]);
    return result;
  }

}