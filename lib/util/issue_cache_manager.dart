import 'dart:collection';

import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/git_comment.dart';

class IssueCacheManager {
  static const _prefix_issue = 'issue_';
  static const _prefix_comment = 'comments_';
  static const int _max_count = 30;
  static Map<String, dynamic> _cache = LinkedHashMap();

  static saveIssueCache(int number, String body) {
    _setData(_prefix_issue + number.toString(), body);
  }

  static String getIssueCache(int number) {
    return _getData(_prefix_issue + number.toString()) ?? '';
  }

  static PagingData<GitComment> getIssueComments(int number) {
    return _getData(_prefix_comment + number.toString());
  }

  static saveIssueComments(int number, PagingData<GitComment> data) {
    _setData(_prefix_comment + number.toString(), data);
  }

  static removeCommentItem(int number, GitComment comment) {
    var data = getIssueComments(number);
    if (data != null) {
      data.data.remove(comment);
    }
  }

  static _setData(String key, dynamic value) {
    if (_cache.containsKey(key)) {
      _cache.remove(key);
    }
    _cache[key] = value;
    _checkCount();
  }

  static _getData(String key) {
    if (_cache.containsKey(key)) {
      var cache = _cache.remove(key);
      _cache[key] = cache;
      return cache;
    }
    return null;
  }

  static void _checkCount() {
    while (_cache.length > _max_count) {
      _cache.remove(_cache.keys.first);
    }
  }
}
