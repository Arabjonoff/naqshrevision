import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/model/baselist_model.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc{
  final Repository _repository = Repository();
  final _fetchCartInfo = PublishSubject<List<BaseListResult>>();
  Stream<List<BaseListResult>> get getCartStream => _fetchCartInfo.stream;

  getCartAll()async{
    var data = await _repository.getCartList();
    _fetchCartInfo.sink.add(data);
  }
}
final cartBloc = CartBloc();