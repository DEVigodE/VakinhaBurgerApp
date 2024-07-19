import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/local_storage_constants.dart';
import '../../global/global_context.dart';

final class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageConstants.accessToken)}',
      });
    }
    handler.next(options);

    //super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      GlobalContext.instance.loginExpire();
      // } else if (err.type == DioExceptionType.connectionTimeout) {
      //   GlobalContext.instance.connectionTimeout();
      //   handler.next(err);
    } else {
      handler.next(err);
    }
  }
}
