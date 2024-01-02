import 'package:naqshrevision/src/api/repository.dart';
import 'package:naqshrevision/src/model/barcode/barcode_model.dart';
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:rxdart/rxdart.dart';

class BarcodeBloc{
  final Repository _repository = Repository();
  final _fetchBarcodeInfo = PublishSubject<List<BarcodeResult>>();
  Stream<List<BarcodeResult>> get barcodeStream => _fetchBarcodeInfo.stream;

  getBarcodeAll()async{
    List<BarcodeResult> barcodeBase = await _repository.getBarcode();
    _fetchBarcodeInfo.sink.add(barcodeBase);
    HttpResult result = await _repository.getBarcodeApi();
    if(result.isSuccess){
      BarCodeModel data = BarCodeModel.fromJson(result.result);
      if(barcodeBase.isEmpty){
        for(int i = 0; i < data.data.length; i++){
          await _repository.saveBarCode(data.data[i]);
        }
        print('************************************************************************************');
        print('SAVE BARCODE');
      }if(barcodeBase.isNotEmpty){
        if(barcodeBase.last.vaqt.toString() != data.data.last.vaqt.toString()){
          await _repository.clearBarcode();
          for(int i = 0; i < data.data.length; i++){
            await _repository.saveBarCode(data.data[i]);
          }
          print('################################################################################');
          print('UPDATE BARCODE');
        }
        else{
          print('&&&&&&&&&&&&&&&&&&&&&&&&&');
          print('NO CHANGE');
        }
      }

      _fetchBarcodeInfo.sink.add(data.data);
    }
  }
}

final barcodeBloc = BarcodeBloc();