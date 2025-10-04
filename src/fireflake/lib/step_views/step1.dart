import 'package:flutter/material.dart';

class StepOnePage extends StatefulWidget {
  const StepOnePage({super.key});

  @override
  State<StepOnePage> createState() => _StepOnePageState();
}

class _StepOnePageState extends State<StepOnePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is Step 1'),
    );
  }
}
