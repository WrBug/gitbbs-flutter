import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gitbbs/constant/GitConstant.dart';
import 'package:gitbbs/constant/NetworkConstant.dart';
import 'package:gitbbs/model/cachemanager/user_cache_manager.dart';
import 'package:gitbbs/network/Request.dart';

class GitHttpClient {
  Dio _dio;
  String _baseUrl;

  GitHttpClient(this._baseUrl) {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      if (ENABLE_PROXY) {
        client.findProxy = (uri) {
          //proxy all request to localhost:8888
          return "PROXY $PROXY_ADDRESS:$PROXY_PORT";
        };
      }
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    _dio.interceptors.add(TokenInterceptor());
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
    } else if (request.method == Method.POST) {
      var response = await _dio.post(request.path,
          data: request.params, options: Options(headers: header));
      return response;
    } else if (request.method == Method.PATCH) {
      var response = await _dio.patch(request.path,
          data: request.params, options: Options(headers: header));
      return response;
    } else if (request.method == Method.PUT) {
      var response = await _dio.put(request.path,
          data: request.params, options: Options(headers: header));
      return response;
    }
    return null;
  }
}

class TokenInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    if (!options.headers.containsKey('Authorization')) {
      var token = UserCacheManager.getToken();
      if (token?.isNotEmpty == true) {
        options.headers['Authorization'] =
            'token ${UserCacheManager.getToken()}';
      } else {
        if (options.headers.containsKey(default_token_key)) {
          options.headers['Authorization'] =
              'token ${options.headers[default_token_key]}';
          options.headers.remove(default_token_key);
        }
      }
    }
    if (options.headers.containsKey(default_token_key)) {
      options.headers.remove(default_token_key);
    }
    return super.onRequest(options);
  }

  @override
  onError(DioError err) {
    if (err?.response?.statusCode == 401) {
      UserCacheManager.removeCache();
      err.request.headers.clear();
    }
    return super.onError(err);
  }
}
