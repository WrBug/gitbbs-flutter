import 'package:gitbbs/util/disk_lru_cache.dart';

class EditTextCacheManager {
  static DiskLruCache lruCache = DiskLruCache(30, 'EditTextCacheManager');

  static void save(String key, String content) {
    lruCache.put(key, content);
  }

  static Future<String> get(String key) async {
    return lruCache.get(key);
  }

  static void delete(String key) {
    lruCache.put(key, '');
  }
}
