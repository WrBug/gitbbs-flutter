import 'dart:collection';

typedef int SizeOf<T>(T data);

class LruCache<T> {
  int _currentSize = 0;
  final int maxSize;
  SizeOf<T> sizeOf = (value) => 1;
  Map<String, T> _cache = LinkedHashMap();

  LruCache(this.maxSize, {SizeOf sizeof}) {
    this.sizeOf = sizeOf;
  }

  void put(String key, T value) {
    if (_cache.containsKey(key)) {
      T data = _cache.remove(key);
      _currentSize -= sizeOf(data);
    }
    _cache[key] = value;
    _calcSize(value);
  }

  T get(String key) {
    if (!_cache.containsKey(key)) {
      return null;
    }
    T value = _cache.remove(key);
    _cache[key] = value;
    return value;
  }

  bool containsKey(String key) => _cache.containsKey(key);

  Map<String, T> getData() {
    return LinkedHashMap.of(_cache);
  }

  void _calcSize(T value) {
    int size = sizeOf(value);
    _currentSize += size;
    int delta = _currentSize - maxSize;
    if (delta > 0) {
      while (delta > 0) {
        var key = _cache.keys.first;
        T value = _cache.remove(key);
        int s = sizeOf(value);
        delta -= s;
      }
      _currentSize = maxSize + delta;
    }
  }
}
