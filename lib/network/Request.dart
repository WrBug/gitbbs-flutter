class Request {
  String path;
  Map params;
  Method method;

  Request(this.path, this.params, this.method);

  String toParams() {
    String paramStr = '?';
    params.forEach((key, value) {
      paramStr += key + "=" + value + "&";
    });
    return paramStr;
  }
}

enum Method { POST, GET }
