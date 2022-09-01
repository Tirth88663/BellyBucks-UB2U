import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 550;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 550 &&
      MediaQuery.of(context).size.width <= 1000;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1000;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 1000) {
      return desktop;
    } else if (size.width >= 550 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
