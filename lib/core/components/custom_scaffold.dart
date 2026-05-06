import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.systemNavigationBarColor,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.systemNavigationBarIconBrightness,
    this.backgroundColor,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButton,
  });
  final Color? systemNavigationBarColor;
  final Color? statusBarColor;
  final Brightness? statusBarIconBrightness;
  final Brightness? systemNavigationBarIconBrightness;
  final Color? backgroundColor;
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
