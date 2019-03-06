import 'package:gitbbs/network/Request.dart';

class V4Request extends Request {
  V4Request(Map<String, dynamic> params) : super('/graphql', params, Method.POST);
}
