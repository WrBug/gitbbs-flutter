import 'package:dio/dio.dart';
import 'package:gitbbs/constant/GitConstant.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/event/UserUpdatedEvent.dart';
import 'package:gitbbs/model/event/refresh_list_event.dart';
import 'package:gitbbs/nativebirdge/MmkvChannel.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/model/GithubV4Issue.dart';
import 'package:gitbbs/network/github/model/github_gist.dart';
import 'package:gitbbs/network/github/model/github_gist_file.dart';
import 'package:gitbbs/util/disk_lru_cache.dart';
import 'package:gitbbs/util/event_bus_helper.dart';
import 'dart:convert';

class UserCacheManager {
  static String _token = '';
  static GitUser _user;
  static MmkvChannel _mmkvChannel = MmkvChannel.getInstance();
  static GitHttpRequest _request = GitHttpRequest.getInstance();
  static DiskLruCache _lruCache = DiskLruCache(10, 'user');
  static GithubGist _favoriteGist;
  static bool _authFailed;

  static Map<String, GitIssue> _issueMap;
  static List<GitIssue> _favoriteIssueList;

  static init() {
    _mmkvChannel.getToken().then((token) {
      _token = token;
      _mmkvChannel.getUser().then((user) {
        _user = user;
        _lruCache = DiskLruCache(10, user?.getName());
        EventBusHelper.fire(UserUpdatedEvent(user, _authFailed));
        _checkToken(_user?.getName());
      });
    });
  }

  static removeCache() {
    _user = null;
    _mmkvChannel.saveUser(null);
    _mmkvChannel.saveToken('');
    _favoriteGist = null;
    _authFailed = true;
    _favoriteIssueList?.clear();
    _token = '';
    _issueMap?.clear();
    init();
  }

  static saveToken(String token, String username) {
    _token = token;
    _user = null;
    _mmkvChannel.saveToken(token);
    _checkToken(username);
  }

  static updateIssuesCount(int count) {
    _user.issuesCount = count;
    _mmkvChannel.saveUser(_user);
  }

  static Future<List<GitIssue>> getFavoriteList() async {
    if (_favoriteIssueList != null) {
      return _favoriteIssueList;
    }
    await _initFavoriteList();
    return _favoriteIssueList;
  }

  static Future<Map<String, GitIssue>> getFavoriteMap() async {
    if (_issueMap != null) {
      return _issueMap;
    }
    await _initFavoriteList();
    return _issueMap;
  }

  static void addFavorite(GitIssue issue) {
    GitIssue newIssue = issue.clone();
    String text = newIssue.bodyText ?? '';
    newIssue.setBodyText(text.length > 100 ? text.substring(0, 100) : text);
    newIssue.body = '';
    if (_issueMap?.containsKey(newIssue.getId()) == true) {
      return;
    }
    _favoriteIssueList.add(newIssue);
    _issueMap[newIssue.getId()] = newIssue;
    _saveFavorite();
  }

  static void removeFavorite(String id) {
    if (_issueMap?.containsKey(id) != true) {
      return;
    }
    var issue = _issueMap.remove(id);
    _favoriteIssueList.remove(issue);
    _saveFavorite();
  }

  static Stream<UserUpdatedEvent> addUserChangedListener() {
    return EventBusHelper.on<UserUpdatedEvent>();
  }

  static saveFavoriteGist(GithubGist gist) {
    _favoriteGist = gist;
    _issueMap = null;
    _favoriteIssueList = null;
    DiskLruCache.getDefault()
        .put(favorite_gist_file_name, jsonEncode(gist.toJson()));
  }

  static GitUser getUser() {
    return _user;
  }

  static String getToken() {
    return _token;
  }

  static bool isAuthFailed() {
    return _authFailed;
  }

  static _checkToken(String username) {
    if (_token == '' || _token == null) {
      _authFailed = true;
      return;
    }
    _request.doAuthenticated(_token, username).then((user) {
      _authFailed = false;
      if (!user.isEqual(_user)) {
        _user = user;
        _mmkvChannel.saveUser(user);
        EventBusHelper.fire(UserUpdatedEvent(user, _authFailed));
      }
    }).catchError((e) {
      if ((e is DioError) && (e.response?.statusCode == 401)) {
        _authFailed = true;
        EventBusHelper.fire(UserUpdatedEvent(null, true));
      } else {
        _authFailed = false;
        EventBusHelper.fire(UserUpdatedEvent(_user, _authFailed));
      }
    });
  }

  static void _saveFavorite() {
    _saveFavoriteLocal();
    _saveFavoriteNetwork();
    EventBusHelper.fire(LoadFavoriteListEvent());
  }

  static void _saveFavoriteLocal() {
    _favoriteGist.files = {
      favorite_gist_file_name: jsonEncode(_favoriteIssueList)
    };
    _lruCache.put(favorite_gist_file_name, jsonEncode(_favoriteGist.toJson()));
  }

  static void _saveFavoriteNetwork() {
    GithubGistFile file = GithubGistFile();
    file.content = jsonEncode(_favoriteIssueList);
    file.filename = favorite_gist_file_name;
    _request.saveConfigGist({file.filename: file});
  }

  static Future _initFavoriteList() async {
    if (_favoriteGist == null) {
      String json = await _lruCache.get(favorite_gist_file_name);
      if (json == '') {
        return null;
      }
      var map = jsonDecode(json);
      _favoriteGist = GithubGist.fromJson(map);
    }
    _issueMap = Map();
    _favoriteIssueList = List();
    if (_favoriteGist == null) {
      return null;
    }
    String json = _favoriteGist.files[favorite_gist_file_name];
    List list = jsonDecode(json);

    list.forEach((map) {
      var githubV4Issue = GithubV4Issue.fromJson(map);
      _favoriteIssueList.add(githubV4Issue);
      _issueMap[githubV4Issue.getId()] = githubV4Issue;
    });
  }
}
