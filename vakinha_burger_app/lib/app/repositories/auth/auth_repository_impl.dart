import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/custom_dio/custom_dio.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/unauthorized_exception.dart';
import '../../models/auth_model.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<AuthModel> loginUser(String email, String password) async {
    try {
      final result = await dio.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return AuthModel.fromMap(result.data);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('LOG: Permissão negada', error: e, stackTrace: s, name: 'AuthRepositoryImpl -> loginUser');
        throw UnauthorizedException();
      }

      log('LOG: Erro ao realizar login', error: e, stackTrace: s, name: 'AuthRepositoryImpl -> loginUser');
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> registerUser(String name, String email, String password) async {
    try {
      await dio.unAuth.post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } on DioException catch (e, s) {
      log('LOG: Erro ao registrar usuário', error: e, stackTrace: s, name: 'AuthRepositoryImpl -> registerUser');
      throw RepositoryException(message: 'Erro ao registrar usuário');
    }
  }
}
