import 'package:gitbbs/constant/GitConstant.dart';
import 'package:gitbbs/network/github/v4/V4Request.dart';

class DefaultTokenV4Request extends V4Request {
  DefaultTokenV4Request(Map<String, dynamic> params)
      : super(params, header: {DEFAULT_TOKEN_KEY: '$DEFAULT_TOKEN'});
}
