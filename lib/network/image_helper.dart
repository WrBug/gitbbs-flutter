import 'dart:io';

import 'package:dio/dio.dart';

const _base_url = 'https://sm.ms/api/upload';

class ImageHelper {
  static Dio _dio = Dio(BaseOptions(baseUrl: _base_url));

  static Future<String> upload(File file) async {
    FormData formData = new FormData.from({
      "format": "json",
      "smfile": new UploadFileInfo(
          file,
          'img' +
              file.path.substring(file.path.lastIndexOf('.', file.path.length)))
    });
    var response = await _dio.post('', data: formData);
    Map data = response.data;
    if (data['code'] == 'success') {
      return 'https://i.loli.net' + data['data']['path'];
    }
    return '';
  }
}
