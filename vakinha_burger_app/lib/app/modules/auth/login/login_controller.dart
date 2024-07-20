import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/unauthorized_exception.dart';
import '../../../repositories/auth/auth_repository.dart';
import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginController(this._authRepository) : super(const LoginState.initial());

  void login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await _authRepository.loginUser(email, password);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('accesssToken', authModel.accessToken);
      await sp.setString('refreshToken', authModel.refreshToken);
      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (e, s) {
      log('LOG: Email ou senha inválidos', error: e, stackTrace: s, name: 'LoginController');
      emit(state.copyWith(status: LoginStatus.loginError, errorMessage: 'Email ou senha inválidos'));
    } catch (e, s) {
      log('LOG: Erro ao realizar login', error: e, stackTrace: s, name: 'LoginController');
      emit(state.copyWith(status: LoginStatus.error, errorMessage: 'Erro ao realizar login'));
    }
  }
}
