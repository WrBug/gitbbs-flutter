import 'package:gitbbs/network/Request.dart';

class V4Request extends Request {
  V4Request(Map<String, dynamic> params, {Map<String, dynamic> header})
      : super('/graphql', params, Method.POST, header: header);
}
