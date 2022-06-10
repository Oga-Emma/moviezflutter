import 'package:get/get.dart';

import 'failure.dart';

class ApiRequestFailure extends Failure {
  final Response response;

  ApiRequestFailure(this.response);

  String get message {
    return _extractErrorMessage();
  }

  String get error => response.body['error'] ?? "${response.body}";

  String _extractErrorMessage() {
    //perform error message transformation here
    return response.bodyString ?? "";
  }
}
