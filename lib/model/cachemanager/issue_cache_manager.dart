import 'dart:collection';
import 'dart:convert';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/git_comment.dart';
import 'package:gitbbs/network/github/model/GithubComment.dart';
import 'package:gitbbs/util/disk_lru_cache.dart';
import 'package:gitbbs/util/lru_cache.dart';

class IssueCacheManager {
  static const _prefix_issue = 'issue_';
  static const _prefix_comment = 'comments_';
  static DiskLruCache lruCache = DiskLruCache(30, 'IssueCacheManager');

  static saveIssueCache(int number, String body) {
    _setData(_prefix_issue + number.toString(), body);
  }

  static deleteIssueCache(int number) {
    _setData(_prefix_issue + number.toString(), '');
  }

  static Future<String> getIssueCache(int number) async {
    return await _getData(_prefix_issue + number.toString()) ?? '';
  }

  static Future<PagingData<GitComment>> getIssueComments(int number) async {
    var json = await _getData(_prefix_comment + number.toString());
    if (json == '') {
      return null;
    }
    var map = jsonDecode(json);
    List list = List.of(map['data']);
    List<GitComment> comments = list.map<GitComment>((map) {
      return GithubComment.fromJson(map);
    }).toList();
    return PagingData(map['hasNext'], comments);
  }

  static saveIssueComments(int number, PagingData<GitComment> data) {
    var list = data.data.map((comment) {
      return comment.toJson();
    }).toList();
    _setData(_prefix_comment + number.toString(), data.toJson(list));
  }

  static removeCommentItem(int number, GitComment comment) async {
    var data = await getIssueComments(number);
    if (data != null) {
      data.data.remove(comment);
    }
  }

  static _setData(String key, String value) {
    lruCache.put(key, value);
  }

  static Future<String> _getData(String key) async {
    return await lruCache.get(key);
  }
}
