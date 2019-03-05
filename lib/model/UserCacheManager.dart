import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/model/event/UserUpdatedEvent.dart';
import 'package:gitbbs/nativebirdge/MmkvChannel.dart';
import 'package:gitbbs/network/GitHttpRequest.dart';
import 'package:gitbbs/network/github/GithubHttpRequest.dart';
import 'package:gitbbs/util/EventBusHelper.dart';

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
        EventBusHelper.fire(UserUpdatedEvent(user, _authFailed));
        _checkToken();
      });
    });
  }

  static saveToken(String token) {
    _token = token;
    _user = null;
    _mmkvChannel.saveToken(token);
    _checkToken();
  }

  static Stream<UserUpdatedEvent> addUserChangedListener() {
    return EventBusHelper.on<UserUpdatedEvent>();
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
    if (_token == '' || _token == null) {
      return;
    }
    _request.doAuthenticated(_token).then((user) {
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
