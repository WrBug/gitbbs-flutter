class Request {
  String path;
  Map<String, dynamic> params;
  Method method;
  Map<String, dynamic> header;

  Request(this.path, this.params, this.method, {this.header});

  String toParams() {
    String paramStr = '?';
    params.forEach((key, value) {
      paramStr += key + "=" + value + "&";
    });
    return paramStr;
  }
}

enum Method { POST, GET }
