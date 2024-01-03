import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:naqshrevision/src/model/skl2model.dart';
import 'package:rxdart/rxdart.dart';

class Skl2BaseBloc{
  final Repository _repository = Repository();
  final _fetchSkl2BaseInfo = PublishSubject<List<Skl2Result>>();
  Stream<List<Skl2Result>> get getSkl2Stream => _fetchSkl2BaseInfo.stream;

  getAllSkl2()async{
    HttpResult result = await _repository.skl2BaseRevision();
    var dataSkl2 = await _repository.getSkl2Base();
    _fetchSkl2BaseInfo.sink.add(dataSkl2);
    if(dataSkl2.isEmpty){
      if(result.isSuccess){
        print("-------------CREATE SKL2BASE--------------");
        var data = Skl2BaseModel.fromJson(result.result);
        for(int i=0;i<data.data.length;i++){
          await _repository.saveSkl2Base(data.data[i]);
        }
        _fetchSkl2BaseInfo.sink.add(data.data);
      }
    }
    else{
      print("-------------UPDATE SKL2BASE--------------");
    }
  }
}
final skl2BaseBloc = Skl2BaseBloc();