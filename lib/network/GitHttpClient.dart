import 'package:dio/dio.dart';
import 'package:gitbbs/network/Request.dart';

class GitHttpClient {
  Dio _dio;
  String _token;
  String _baseUrl;
  Map _defaultHeader;

  GitHttpClient(this._baseUrl) {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  setToken(String token) {
    _dio.options.headers = {'Authorization': 'token $token'};
  }

  Future<Response> execute(Request request) async {
    Map header = _dio.options.headers;
    if (request.header != null) {
      header.addAll(request.header);
    }
    if (request.method == Method.GET) {
      var response = await _dio.get(request.path,
          queryParameters: request.params, options: Options(headers: header));
      return response;
    } else {
      var response = await _dio.post(request.path,
          data: request.params, options: Options(headers: header));
      return response;
    }
  }
}
