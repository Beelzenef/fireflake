import 'package:flutter/material.dart';

class SaveProjectButton extends StatefulWidget {
  const SaveProjectButton({
    super.key,
    required this.onPressed,
    this.label = 'Save Project',
  });

  final Future<void> Function() onPressed;
  final String label;

  @override
  State<SaveProjectButton> createState() => _SaveProjectButtonState();
}

class _SaveProjectButtonState extends State<SaveProjectButton> {
  bool _saving = false;

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await widget.onPressed();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _saving ? null : _save,
        icon: const Icon(Icons.save_outlined),
        label: Text(_saving ? 'Saving...' : widget.label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
