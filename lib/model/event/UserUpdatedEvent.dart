import 'package:gitbbs/model/GitUser.dart';

class UserUpdatedEvent {
  GitUser user;
  bool authFailed;

  UserUpdatedEvent(this.user, this.authFailed);
}
