import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/local_storage_constants.dart';

class GlobalContext {
  late GlobalKey<NavigatorState> _navigatorKey;

  static GlobalContext? _instance;

  GlobalContext._();
  static GlobalContext get instance => _instance ??= GlobalContext._();

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;
  GlobalKey<NavigatorState> get getNavigatorKey => _navigatorKey;

  void loginExpire() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove(LocalStorageConstants.accessToken);
    ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Login Expirado',
          message: 'Login Expirado, faça login novamente',
          contentType: ContentType.failure,
        ),
      ),
    );
    Navigator.of(_navigatorKey.currentContext!, rootNavigator: true).pop();
    Navigator.of(_navigatorKey.currentContext!).pushNamed('/login');
  }

  void connectionTimeout() {
    Navigator.of(_navigatorKey.currentContext!, rootNavigator: true).pop();
    ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Erro de Conexão',
          messageFontSize: 12,
          message:
              'Ops! Parece que a consulta está demorando mais do que o esperado. Tente novamente em alguns instantes ou entre em contato conosco para obter ajuda.',
          contentType: ContentType.failure,
        ),
      ),
    );
  }
}
