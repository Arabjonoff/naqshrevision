import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naqshrevision/src/model/http_result.dart';
import 'package:naqshrevision/src/model/revision/revision_model.dart';
import 'package:naqshrevision/src/utils/cache.dart';
String _baseUrl = "https://naqshsoft.site/";
String db = CacheService.getDb();
class ApiProvider{
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  // var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  getReqHeader() {
    String token = '';
    if (token == "") {
      return {
        "Accept": "application/json",
        // "X-Device": "device",
      };
    } else {
      return {
        "Accept": "application/json",
      };
    }
  }
  Future<HttpResult> _getRequest(String url) async {
    final dynamic headers = await getReqHeader();
    http.Response response = await http.get(Uri.parse(url),headers: headers);
    print(url);
    return await _result(response);
  }

  Future<HttpResult> _postRequest(String url,body) async {
    final dynamic headers = await getReqHeader();
    http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers
    );
    print(url);
    print(body);

    return await _result(response);
  }

  Future<HttpResult> _patchRequest(String url,body) async {
    final dynamic headers = await getReqHeader();
    http.Response response = await http.patch(
        Uri.parse(url),
        body: body,
        headers: headers
    );
    print(url);
    print(body);

    return await _result(response);
  }

  Future<HttpResult> _deleteRequest(String url,body) async {
    final dynamic headers = await getReqHeader();
    http.Response response = await http.delete(
        Uri.parse(url),
        body: body,
        headers: headers
    );
    print(url);
    print(body);

    return await _result(response);
  }

  _result(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.body);
      print(response.statusCode);
      return  HttpResult(
        statusCode: response.statusCode,
        isSuccess: true,
        result: json.decode(utf8.decode(response.bodyBytes)),
      );
    } else {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: false,
        result: json.decode(utf8.decode(response.bodyBytes)),
      );
    }
  }
  Future<HttpResult> login(name,password,db)async{
    String url = "${_baseUrl}login-api.php?DB=$db";
    var data = {
      "name":name,
      "password":password
    };
    return await _postRequest(url,json.encode(data));
  }
  Future<HttpResult>baseList()async{
    String url = "${_baseUrl}sklad01?DB=002&YIL=2023&OY=12&ID_SKL0=1";
    return await _getRequest(url);
  }
  Future<HttpResult> barcode()async{
    String url = "${_baseUrl}shtr?DB=002";
    return await _getRequest(url);
  }

  Future<HttpResult> postRevision(RevisionResult item)async{
    String url = "${_baseUrl}omb_rev_m?DB=002&YIL=2024&OY=1&ID_SKL=1";
    return await _postRequest(url,json.encode(item));
  }

  Future<HttpResult> getRevision()async{
    String url = "${_baseUrl}rev?DB=002&YIL=$year&OY=$month&ID_SKL=1";
    return await _getRequest(url);
  }

  Future<HttpResult> deleteRevision(id)async{
    String url = "${_baseUrl}rev0_del?DB=002&ID=$id";
    var data = {"ID":id};
    return await _deleteRequest(url,json.encode(data));
  }

  Future<HttpResult> lockRevision(id,prov)async{
    String url = "${_baseUrl}rev0_prov?DB=$db";
    var data = {
      "ID":id,
      "PROV":prov
    };
    return await _patchRequest(url,json.encode(data));
  }
}