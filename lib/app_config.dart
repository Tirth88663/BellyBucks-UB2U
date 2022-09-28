import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final String appTitle;
  final String buildFlavor;
  final Widget child;

  const AppConfig({
    required this.appTitle,
    required this.buildFlavor,
    required this.child,
  }) : super(child: child);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
