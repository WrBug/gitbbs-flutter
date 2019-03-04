import 'dart:convert';

abstract class GitUser {
  String toJsonString() {
    return JsonEncoder().convert(this);
  }
}
