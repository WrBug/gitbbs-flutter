import 'package:gitbbs/model/GitUser.dart';

class UserUpdatedEvent {
  GitUser user;

  UserUpdatedEvent(this.user);
}
