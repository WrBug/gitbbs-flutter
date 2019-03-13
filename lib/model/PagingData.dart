import 'dart:convert';

class PagingData<T> {

  bool hasNext;
  List<T> data;
  int nextPage;

  PagingData(this.hasNext, this.data);

  String toJson(List<Map> data) {
    var map={
    'hasNext':hasNext,
    'data':data,
    'nextPage':nextPage
  };
    return jsonEncode(map);
  }
}
