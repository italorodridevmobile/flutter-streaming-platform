import 'package:flutter/material.dart';

abstract class NavigatorApp {
  /// Empilha uma nova tela (Equivalente ao push)
  static void to(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Substitui a tela atual (Equivalente ao pushReplacement)
  static void replace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Volta para a tela anterior (Equivalente ao pop)
  static void back(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}