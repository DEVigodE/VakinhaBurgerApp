import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../repositories/auth/auth_repository.dart';
import 'register_state.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterController(this._authRepository) : super(const RegisterState.initial());

  void register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _authRepository.registerUser(name, email, password);
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e, s) {
      log('LOG: Erro ao registrar usuário', error: e, stackTrace: s, name: 'RegisterController');
      emit(state.copyWith(status: RegisterStatus.error, errorMessage: 'Erro ao registrar usuário'));
    }
  }
}
