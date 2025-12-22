import 'package:flutter/material.dart';

class SaveProjectButton extends StatelessWidget {
  const SaveProjectButton({
    super.key,
    required this.onPressed,
    this.label = 'Save Project',
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.save_outlined),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
