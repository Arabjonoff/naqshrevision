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
      if(data.data.isNotEmpty){
        for(int i=0;i<dataSkl.length;i++){
          for(int k = 0; k<data.data.length;k++){
            for(int j=0;j<data.data[k].sklRevTov.length;j++){
              if(dataSkl[i].id == data.data[k].sklRevTov[j].idSkl2){
                data.data[k].sklRevTov[j].name = dataSkl[i].name;
              }
            }
          }
        }
      }
      _fetchRevisionInfo.sink.add(data);
    }
  }
}
final revisionBloc = RevisionBloc();