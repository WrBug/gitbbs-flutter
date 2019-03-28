import 'dart:convert';

import 'package:fish_redux/fish_redux.dart';

abstract class GitUser implements Cloneable<GitUser> {
  String getAvatarUrl();

  String getName();

  String bio;
  int issuesCount;

  bool isEqual(GitUser other) {
    if (other == null) {
      return false;
    }
    if (this == other) {
      return true;
    }

    return toJsonString() == other.toJsonString();
  }

  String toJsonString() {
    return JsonEncoder().convert(this);
  }
}
