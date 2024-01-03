import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:naqshrevision/src/model/skl2model.dart';
import 'package:rxdart/rxdart.dart';

import '../../model/baselist_model.dart';

class RevisionBloc{
  final Repository _repository = Repository();
  final _fetchRevisionInfo = PublishSubject<RevisionModel>();
  Stream<RevisionModel> get getRevisionStream => _fetchRevisionInfo.stream;

  getAllRevision()async{
    HttpResult res = await _repository.getRevision();
    List<Skl2Result> dataSkl = await _repository.getSkl2Base();
    if(res.isSuccess){
      var data = RevisionModel.fromJson(res.result);
      for(int i=0;i<dataSkl.length;i++){
        for(int j=0;j<data.data[0].sklRevTov.length;j++){
          print(dataSkl[i].id);
          print(data.data[0].sklRevTov[j].idSkl2);
          print(dataSkl[i].id == data.data[0].sklRevTov[j].idSkl2);
          if(dataSkl[i].id == data.data[0].sklRevTov[j].idSkl2){
            data.data[0].sklRevTov[j].name = dataSkl[i].name;
            print("data.data[0].sklRevTov[j].name221111111");
            print(data.data[0].sklRevTov[j].name);
          }
        }
      }
      _fetchRevisionInfo.sink.add(data);
    }
  }
}
final revisionBloc = RevisionBloc();