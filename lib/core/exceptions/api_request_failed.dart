import 'package:get/get_connect/http/src/response/response.dart';

class ApiRequestFailed implements Exception {
  final Response response;

  const ApiRequestFailed(this.response);

  String get message => response.bodyString ?? '';

  String get debugMessage {
    return '''
      Path: ${response.request?.url.path}
      Status: ${response.statusCode}
      Response: ${response.bodyString}
      Query: ${response.request?.url.queryParameters}
    ''';
  }

  @override
  String toString() => 'ApiRequestFailed: $debugMessage';
}
