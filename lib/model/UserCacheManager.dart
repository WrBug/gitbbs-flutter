import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/nativebirdge/MmkvChannel.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';

class UserCacheManager {
  static String _token = '';
  static GitUser _user;
  static MmkvChannel _mmkvChannel = MmkvChannel.getInstance();
  static GitHttpRequest _request = GithubHttpRequest.getInstance();
  static bool _authFailed = false;

  static init() {
    _mmkvChannel.getToken().then((token) {
      _token = token;
      _mmkvChannel.getUser().then((user) {
        _user = user;
        _checkToken();
      });
    });
  }

  static saveToken(String token) {
    _token = token;
    _mmkvChannel.saveToken(token);
    _checkToken();
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

  static _checkToken() {
    _request.doAuthenticated(_token, (success, user) {
      _authFailed = !success;
      if (success) {
        _user = user;
        _mmkvChannel.saveUser(user);
      }
    });
  }
}
