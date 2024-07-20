import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'app/app_widget.dart';

void main() {
  runZonedGuarded(() async {
    runApp(AppWidget());
  }, (error, stack) {
    log('Erro não tratado', error: error, stackTrace: stack, name: 'main.dart');
    throw error;
  });
}
