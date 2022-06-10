import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:moviezflutter/core/config/application.dart';
import 'package:moviezflutter/core/exceptions/api_request_failed.dart';

class AppConnect extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.timeout = const Duration(minutes: 1);
    httpClient.baseUrl = Application.baseUrl;

    httpClient.addRequestModifier((Request request) async {
      // Set the header
      request.headers["Content-Type"] = "application/json";
      // request.url.queryParameters['api_key'] = Application.apiKey;

      print(request.url);

      return request;
    });
  }

  Future<Map<String, dynamic>> get_(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    final res = await get(url, query: query);

    if (!res.isOk) {
      throw ApiRequestFailed(res);
    }

    if (res.body is Map) {
      return res.body;
    }

    return res.body;
  }

  Future<Map<String, dynamic>> patch_(String url,
      {Map<String, dynamic>? body}) async {
    final res = await patch(
      url,
      body,
    );

    if (!res.isOk) {
      throw ApiRequestFailed(res);
    }

    if (res.body is! Map) {
      return {'data': res.body};
    }

    return res.body;
  }

  Future<Map<String, dynamic>> put_(String url,
      {Map<String, dynamic>? body}) async {
    final res = await put(
      url,
      body,
    );

    if (!res.isOk) {
      throw ApiRequestFailed(res);
    }

    if (res.body is! Map) {
      return {'data': res.body};
    }

    return res.body;
  }

  Future<Map<String, dynamic>> post_(String url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? query,
      Function(Map<String, dynamic>)? errorCallback}) async {
    final res = await post(
      url,
      body,
      query: query,
    );

    if (!res.isOk) {
      if (errorCallback != null) {
        errorCallback(res.body);
      }
      throw ApiRequestFailed(res);
    }

    if (res.body is! Map) {
      return {'data': res.body};
    }

    return res.body;
  }

  Future<Map<String, dynamic>> delete_(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    final res = await delete(
      url,
      query: query,
    );

    if (!res.isOk) {
      throw ApiRequestFailed(res);
    }

    if (res.body! is Map) {
      return res.body;
    }

    return res.body;
  }
}
