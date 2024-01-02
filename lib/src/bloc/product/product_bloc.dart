import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/model/baselist_model.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc{
  final Repository _repository = Repository();
  final _fetchProductInfo = PublishSubject<List<BaseListResult>>();
  Stream<List<BaseListResult>> get getProductStream => _fetchProductInfo.stream;


  getAllProduct(obj)async{
    List<BaseListResult> dataBase = await _repository.getProductBase(obj);
    _fetchProductInfo.sink.add(dataBase);
    if(dataBase.isEmpty){
      HttpResult response = await _repository.getProductApi();
      if(response.isSuccess){
        BaseListModel data = BaseListModel.fromJson(response.result);
          for(int i = 0;i<data.data.length;i++){
            _repository.saveProductBase(data.data[i]);
          }
          print('^^^^^^^^^^^^^^^ SAVE PRODUCT ^^^^^^^^^^^^^^^^^^^^');
        _fetchProductInfo.sink.add(data.data);
      }
    }
  }
}

final productBloc = ProductBloc();