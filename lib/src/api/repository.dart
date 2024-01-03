import 'package:naqshrevision/src/api/api_provider.dart';
import 'package:naqshrevision/src/database/database_helper.dart';
import 'package:naqshrevision/src/model/barcode/barcode_model.dart';
import 'package:naqshrevision/src/model/baselist_model.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:naqshrevision/src/model/skl2model.dart';

class Repository{
  final ApiProvider _apiProvider = ApiProvider();
  final DataBaseHelper _baseHelper = DataBaseHelper();

  /// Product Base
  Future<List<BaseListResult>> getProductBase(obj) => _baseHelper.getDataBaseList(obj);
  Future<int> saveProductBase(BaseListResult item) => _baseHelper.saveProduct(item);
  Future<void> clearProduct() => _baseHelper.clearProduct();

  /// Barcode Base
  Future<List<BarcodeResult>> getBarcode() => _baseHelper.getBarcode();
  Future<int> saveBarCode(BarcodeResult item) => _baseHelper.saveBarCode(item);
  Future<void> clearBarcode() => _baseHelper.clearBarcode();

  /// Cart Base
  Future<int> saveCart(BaseListResult item) => _baseHelper.saveCart(item);
  Future<List<BaseListResult>> getCartList() => _baseHelper.getCartList();
  Future<int> updateCart(BaseListResult item) => _baseHelper.updateCart(item);
  Future<int> deleteCart(BaseListResult item) => _baseHelper.deleteCart(item);
  Future<void> clearCart() => _baseHelper.clearCart();

  /// skl2Base
  Future<List<Skl2Result>> getSkl2Base() => _baseHelper.getSkl2Base();
  Future<int> saveSkl2Base(Skl2Result item) => _baseHelper.saveSkl2Base(item);
  Future<void> clearSkl2Base() => _baseHelper.clearSkl2Base();

  /// Api Requests
  Future<HttpResult> getProductApi() => _apiProvider.baseList();
  Future<HttpResult> getBarcodeApi() => _apiProvider.barcode();
  Future<HttpResult> sendRevision(item) => _apiProvider.postRevision(item);
  Future<HttpResult> login(name,password,db) => _apiProvider.login(name,password,db);
  Future<HttpResult> getRevision() => _apiProvider.getRevision();
  Future<HttpResult> deleteRevision(id) => _apiProvider.deleteRevision(id);
  Future<HttpResult> lockRevision(int id,prov) => _apiProvider.lockRevision(id,prov);
  Future<HttpResult> skl2BaseRevision() => _apiProvider.skl2BaseRevision();
}