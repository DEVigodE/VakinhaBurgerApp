import '../../models/auth_model.dart';

abstract interface class AuthRepository {
  Future<void> registerUser(String name, String email, String password);
  Future<AuthModel> loginUser(String email, String password);
}
