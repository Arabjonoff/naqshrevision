import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:rxdart/rxdart.dart';

class RevisionBloc{
  final Repository _repository = Repository();
  final _fetchRevisionInfo = PublishSubject<RevisionModel>();
  Stream<RevisionModel> get getRevisionStream => _fetchRevisionInfo.stream;

  getAllRevision()async{
    HttpResult res = await _repository.getRevision();
    if(res.isSuccess){
      var data = RevisionModel.fromJson(res.result);
      _fetchRevisionInfo.sink.add(data);
    }
  }
}
final revisionBloc = RevisionBloc();