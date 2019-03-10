import 'dart:collection';

class IssueCacheManager {
  static const int _max_count = 20;
  static Map<int, String> _cache = LinkedHashMap();

  static saveCache(int number, String body) {
    if (_cache.containsKey(number)) {
      _cache.remove(number);
    }
    _cache[number] = body;
    _checkCount();
  }

  static String getCache(int number) {
    if (_cache.containsKey(number)) {
      String cache = _cache.remove(number);
      _cache[number] = cache;
      return cache;
    }
    return "";
  }

  static void _checkCount() {
    while (_cache.length > _max_count) {
      _cache.remove(_cache.keys.first);
    }
  }
}
