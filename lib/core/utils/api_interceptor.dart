import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:moviezflutter/core/error/api_request_failure.dart';
import 'package:moviezflutter/core/exceptions/api_request_failed.dart';

Future<Either<ApiRequestFailure, R>> apiInterceptor<R>(
    Future<R> Function() func) async {
  try {
    final res = await func();
    return Right(res);
  } on ApiRequestFailed catch (e, stackTrace) {
    debugPrint("Parsing error => ${e.response.bodyString}");
    return Left(ApiRequestFailure(e.response));
  }
}

Future<Either<Exception, R>> dbInterceptor<R>(Future<R> Function() func) async {
  try {
    final res = await func();
    return Right(res);
  } catch (e, stackTrace) {
    debugPrint("Parsing error => $e");
    return Left(Exception("$e"));
  }
}
