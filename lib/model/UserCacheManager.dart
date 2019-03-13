import 'package:gitbbs/constant/GitConstant.dart';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/event/UserUpdatedEvent.dart';
import 'package:gitbbs/nativebirdge/MmkvChannel.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/network/github/model/GithubV4Issue.dart';
import 'package:gitbbs/network/github/model/github_gist.dart';
import 'package:gitbbs/util/disk_lru_cache.dart';
import 'package:gitbbs/util/event_bus_helper.dart';
import 'dart:convert';

class UserCacheManager {
  static String _token = '';
  static GitUser _user;
  static MmkvChannel _mmkvChannel = MmkvChannel.getInstance();
  static GitHttpRequest _request = GitHttpRequest.getInstance();
  static GithubGist _favoriteGist;
  static bool _authFailed = false;

  static init() {
    _mmkvChannel.getToken().then((token) {
      _token = token;
      _mmkvChannel.getUser().then((user) {
        _user = user;
        EventBusHelper.fire(UserUpdatedEvent(user, _authFailed));
        _checkToken(_user?.getName());
      });
    });
  }

  static saveToken(String token, String username) {
    _token = token;
    _user = null;
    _mmkvChannel.saveToken(token);
    _checkToken(username);
  }

  static Future<List<GitIssue>> getFavoriteList() async {
    if (_favoriteGist == null) {
      String json =
          await DiskLruCache.getDefault().get(FAVORITE_GITS_FILE_NAME);
      if (json == '') {
        return null;
      }
      var map = jsonDecode(json);
      _favoriteGist = GithubGist.fromJson(map);
    }
    if (_favoriteGist == null) {
      return null;
    }
    String json = _favoriteGist.files[FAVORITE_GITS_FILE_NAME];
    List list = jsonDecode(json);
    return list.map<GitIssue>((map) {
      return GithubV4Issue.fromJson(map);
    }).toList();
  }

  static Stream<UserUpdatedEvent> addUserChangedListener() {
    return EventBusHelper.on<UserUpdatedEvent>();
  }

  static saveFavoriteGist(GithubGist gist) {
    _favoriteGist = gist;
    DiskLruCache.getDefault()
        .put(FAVORITE_GITS_FILE_NAME, jsonEncode(gist.toJson()));
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
      _authFailed = true;
      EventBusHelper.fire(UserUpdatedEvent(null, true));
    });
  }
}
