import 'package:dio/dio.dart';
import 'package:gitbbs/network/Request.dart';

class GitHttpClient {
  Dio dio;
  String token;
  String baseUrl;
  Map defaultHeader;

  GitHttpClient(this.baseUrl) {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  setToken(String token) {
    dio.options.headers = {'Authorization': 'token $token'};
  }

  Future<Response> execute(Request request) async {
    Map header = dio.options.headers;
    if (request.header != null) {
      header.addAll(request.header);
    }
    if (request.method == Method.GET) {
      var response = await dio.get(request.path,
          queryParameters: request.params, options: Options(headers: header));
      return response;
    } else {
      var response = await dio.post(request.path,
          data: request.params, options: Options(headers: header));
      return response;
    }
  }
}
