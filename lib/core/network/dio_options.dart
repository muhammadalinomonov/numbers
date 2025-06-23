import 'package:dio/dio.dart';
import 'package:numbers/assets/constants/app_constants.dart';

class DioOptions {
  final BaseOptions baseOptions = BaseOptions(
    baseUrl: AppConstants.baseUrlDev,
    connectTimeout: const Duration(milliseconds: 35000),
    receiveTimeout: const Duration(milliseconds: 35000),
    followRedirects: false,
    validateStatus: (status) => status != null && status <= 500,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  Dio get dio {
    final dio = Dio(baseOptions)
      ..interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        request: true,
        requestHeader: true,
      ));

    return dio;
  }
}
