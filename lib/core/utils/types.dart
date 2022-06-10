import 'package:dartz/dartz.dart';
import 'package:moviezflutter/core/error/api_request_failure.dart';

typedef ApiResponse<R> = Either<ApiRequestFailure, R>;
