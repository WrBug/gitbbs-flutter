import 'package:gitbbs/network/Request.dart';

class V4PreViewRequest extends Request {
  V4PreViewRequest(Map<String, dynamic> params)
      : super('/graphql', params, Method.POST,
            header: {'Accept': 'application/vnd.github.starfire-preview+json'});
}
