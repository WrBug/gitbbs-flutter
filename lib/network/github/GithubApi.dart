import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:gitbbs/constant/Constant.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

class GithubApi {
  Dio _dio;
  CookieManager cookieManager;

  GithubApi() {
    _dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 10.1.133.14:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    cookieManager = CookieManager(CookieJar());
    _dio.interceptors.add(cookieManager);
  }

  Future<String> getAuthenticityToken() async {
    var response = await _dio.get('https://github.com/login');
    var html = response.data.toString();
    var document = parse(html);
    String authenticityToken = _getAuthenticityToken(document);
    return authenticityToken;
  }

  Future<String> signIn(String username, String password) async {
    _resetCookie();
    const url = 'https://github.com';
    var token = await getAuthenticityToken();
    var map = {
      'commit': 'Sign in',
      'utf8': '✓',
      'authenticity_token': token,
      'login': username,
      'password': password
    };
    try {
      await _dio.post('https://github.com/session',
          data: map,
          options: Options(
            method: 'POST',
            baseUrl: url,
            contentType: ContentType.parse("application/x-www-form-urlencoded"),
          ));
    } on DioError catch (e) {
      if (e.response != null && e.response.statusCode == 302) {
        cookieManager.onResponse(e.response);
        return createToken();
      }
    }
    return '';
  }

  Future<String> createToken() async {
    var url = 'https://github.com/settings/tokens/new';
    var response = await _dio.get(url);
    var html = response.data.toString();
    var document = parse(html);
    String authenticityToken = _getAuthenticityToken(document);
    var map = {
      'utf8': '✓',
      'authenticity_token': authenticityToken,
      'oauth_access': {
        'description': '$APP_NAME 自动创建[' + DateTime.now().toString() + "]",
        'scopes': ['repo', 'user']
      }
    };
    try {
      await _dio.post('https://github.com/settings/tokens',
          data: map,
          options: Options(
            method: 'POST',
            contentType: ContentType.parse("application/x-www-form-urlencoded"),
          ));
    } on DioError catch (e) {
      if (e.response != null && e.response.statusCode == 302) {
        cookieManager.onResponse(e.response);
        return getNewToken();
      }
    }
    return '';
  }

  Future<String> getNewToken() async {
    var response = await _dio.get('https://github.com/settings/tokens');
    var document = parse(response.data.toString());
    var element = document.getElementsByTagName('code')[0];
    return element.innerHtml;
  }

  String _getAuthenticityToken(Document document) {
    var list = document.getElementsByTagName('input');
    String token = '';
    list.forEach((element) {
      if (element.attributes['name'] == 'authenticity_token') {
        token = element.attributes['value'];
        return token;
      }
    });
    return token;
  }

  void _resetCookie() {
    DefaultCookieJar.domains.forEach((map) {
      map.clear();
    });
  }
}
