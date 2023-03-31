import 'package:flutter/material.dart';

class ThemeBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Brightness brightness) builder;
  final Brightness defaultBrightness;

  ThemeBuilder({required this.builder, required this.defaultBrightness});

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState();

  static _ThemeBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeBuilderState>();
  }
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  Brightness? _brightness;

  @override
  void initState() {
    super.initState();
    _brightness = widget.defaultBrightness;
    print({"Default brightness in Provider", widget.defaultBrightness});

    if (mounted) setState(() {});
  }

  void changeTheme(bool value) {
    print({"called to change theme"});
    setState(() {
      _brightness = value ? Brightness.dark : Brightness.light;
    });
  }

  Brightness getCurrentTheme() {
    return _brightness!;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _brightness!);
  }
}
