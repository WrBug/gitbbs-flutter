import 'dart:collection';
import 'dart:convert';
import 'package:gitbbs/util/lru_cache.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class DiskLruCache {
  static DiskLruCache _default = DiskLruCache(30, 'lru');
  final int maxSize;
  final String cacheDir;
  SizeOf<String> sizeOf = (data) => 1;
  LruCache<List<int>> _cache;
  String _path;

  DiskLruCache(this.maxSize, this.cacheDir) {
    _cache = LruCache(20);
  }

  factory DiskLruCache.getDefault() => _default;

  Future<String> get _localPath async {
    if (_path != null) {
      return _path;
    }
    final directory = await getTemporaryDirectory();
    var path = Directory('${directory.path}/$cacheDir');
    bool exist = await path.exists();
    if (!exist) {
      await path.create();
    }
    _path = path.path;
    return _path;
  }

  Future<String> get(String fileName) async {
    var file = await getFile(fileName);
    if (_cache.containsKey(file.path)) {
      return Utf8Decoder().convert(_cache.get(file.path));
    }
    if (!file.existsSync()) {
      return '';
    }
    var list = file.readAsBytesSync();
    if (list == null) {
      return '';
    }
    _cache.put(file.path, list);
    return Utf8Decoder().convert(list);
  }

  void put(String fileName, String value) async {
    var file = await getFile(fileName);
    var list = Utf8Encoder().convert(value);
    file.writeAsBytes(list);
    _cache.put(file.path, list);
  }

  Future<String> _encodeName(String fileName) async {
    String path = await _localPath + fileName;
    var digest = md5.convert(Utf8Encoder().convert(path));
    return hex.encode(digest.bytes);
  }

  Future<File> getFile(String fileName) async {
    String name = await _encodeName(fileName);
    String path = await _localPath;
    return File('$path/$name');
  }
}
