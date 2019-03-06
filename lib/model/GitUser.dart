import 'dart:convert';

abstract class GitUser {
  String getAvatarUrl();

  String getName();

  String bio;

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