import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/local_storage_constants.dart';
import '../../exceptions/expire_token_exception.dart';
import '../../global/global_context.dart';
import '../custom_dio.dart';

final class AuthInterceptor extends Interceptor {
  final CustomDio dio;

  AuthInterceptor({required this.dio});

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
      try {
        if (err.requestOptions.path != '/auth/refresh') {
          await _refreshToken(err);
          await _retryRequest(err, handler);
        } else {
          GlobalContext.instance.loginExpire();
        }
      } catch (e) {
        GlobalContext.instance.loginExpire();
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken(DioException err) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final refreshToken = sp.getString(LocalStorageConstants.refreshToken);

      if (refreshToken == null) {
        return;
      }

      final resultRefresh = await dio.auth.put(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (resultRefresh.statusCode == 200) {
        sp.setString(LocalStorageConstants.accessToken, resultRefresh.data['access_token']);
        sp.setString(LocalStorageConstants.refreshToken, resultRefresh.data['refrash_token']);
      }
    } on DioException catch (e, s) {
      log('Erro ao atualizar token', error: e, stackTrace: s, name: 'AuthInterceptor');
      throw ExpireTokenException(message: 'Erro ao atualizar token');
    }
  }

  Future<void> _retryRequest(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    final result = await dio.request(
      requestOptions.path,
      options: Options(method: requestOptions.method, headers: requestOptions.headers),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ),
    );
  }
}
