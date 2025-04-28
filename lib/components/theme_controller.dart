import 'package:flutter/material.dart';

class ThemeController extends StatefulWidget {
  final Widget Function(BuildContext, bool isDarkMode, VoidCallback toggleTheme) builder;

  ThemeController({required this.builder});

  @override
  _ThemeControllerState createState() => _ThemeControllerState();
}

class _ThemeControllerState extends State<ThemeController> {
  bool _isDark = false;

  void _toggleTheme() => setState(() => _isDark = !_isDark);

  @override
  Widget build(BuildContext context) => widget.builder(context, _isDark, _toggleTheme);
}
