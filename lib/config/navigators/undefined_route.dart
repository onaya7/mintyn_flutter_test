import 'package:flutter/material.dart';

class UndefinedRoute extends StatelessWidget {
  const UndefinedRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: const Center(
        child: Text('404 Page Not Found'),
      ),
    );
  }
}
