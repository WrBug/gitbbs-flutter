import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gitbbs/ui/widget/loading.dart';
import 'package:image_picker/image_picker.dart';

const _base_url = 'https://sm.ms/api/upload';

class ImageHelper {
  static Dio _dio = Dio(BaseOptions(baseUrl: _base_url));

  // ignore: sdk_version_async_exported_from_core
  static Future<String> pickAndUpload(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return '';
    }
    var dialog = LoadingDialog.show(context, text: '正在上传图片');
    var url = await ImageHelper.upload(image);
    dialog.dismiss();
    return url;
  }

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
