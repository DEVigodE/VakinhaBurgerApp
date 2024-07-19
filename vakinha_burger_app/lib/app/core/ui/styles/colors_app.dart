import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  // Avoid self instance
  ColorsApp._();
  static ColorsApp get i => _instance ??= ColorsApp._();

  // Colors
  final Color primary = const Color(0xFF007D21);
  final Color secondary = const Color(0xFFF88B0C);
}

extension ColorsAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.i;
}
