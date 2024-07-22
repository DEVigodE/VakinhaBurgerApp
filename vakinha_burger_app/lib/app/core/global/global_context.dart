import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GlobalContext {
  late final GlobalKey<NavigatorState> _navigatorKey;

  static GlobalContext? _instance;

  GlobalContext._();
  static GlobalContext get instance => _instance ??= GlobalContext._();

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;
  GlobalKey<NavigatorState> get getNavigatorKey => _navigatorKey;

  void loginExpire() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
    //sp.remove(LocalStorageConstants.accessToken);
    showTopSnackBar(
      _navigatorKey.currentState!.overlay!,
      const CustomSnackBar.error(
        message: 'Login Expirado, faça login novamente',
        backgroundColor: Colors.black,
      ),
    );
    _navigatorKey.currentState!.popUntil(ModalRoute.withName('/home'));

    // .showSnackBar(
    //   SnackBar(
    //     elevation: 0,
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: Colors.transparent,
    //     content: AwesomeSnackbarContent(
    //       title: 'Login Expirado',
    //       message: 'Login Expirado, faça login novamente',
    //       contentType: ContentType.failure,
    //     ),
    //   ),
    // );
    // Navigator.of(_navigatorKey.currentContext!, rootNavigator: true).pop();
    // Navigator.of(_navigatorKey.currentContext!).pushNamed('/auth/login');
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
