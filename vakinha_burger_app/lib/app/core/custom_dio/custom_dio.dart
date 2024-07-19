import 'package:dio/dio.dart';

import 'dio_native.dart' if (dart.library.html) 'dio_browser.dart';
import 'interceptors/auth_interceptor.dart';

class CustomDio extends BaseDio {
  CustomDio()
      : super(
          BaseOptions(
            baseUrl: 'http://192.168.31.190:8080',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.addAll(
      [
        AuthInterceptor(),
        LogInterceptor(
          //request: true,
          requestHeader: true,
          requestBody: true,
          //responseHeader: true,
          responseBody: true,
        ),
      ],
    );
  }

  CustomDio get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  CustomDio get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
