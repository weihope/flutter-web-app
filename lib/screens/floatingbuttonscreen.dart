import 'package:flutter/material.dart';

class FloatingButtonScreen extends StatefulWidget {
  const FloatingButtonScreen({super.key});

  @override
  State<FloatingButtonScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FloatingButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber,
        ),
      ),
    );
  }
}