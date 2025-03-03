import 'package:flutter/material.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Another screen"),
      ),
      body: Center(
        child: Text("Hallo!"),
      ),
    );
  }
}
