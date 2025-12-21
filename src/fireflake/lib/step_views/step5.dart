import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/character.dart';
import '../state/app_cubit.dart';
import '../widgets/save_project_button.dart';
import '../utils/responsive_helper.dart';

class StepFivePage extends StatefulWidget {
  const StepFivePage({super.key});

  @override
  State<StepFivePage> createState() => _StepFivePageState();
}

class _StepFivePageState extends State<StepFivePage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, TextEditingController>> _characterControllers = [];
  static const int _maxCharacters = 5;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _addCharacterField();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    final characters = context.read<AppCubit>().state.characters;
    if (characters.isNotEmpty) {
      _characterControllers.clear();
      for (final char in characters.take(_maxCharacters)) {
        _characterControllers.add({
          'name': TextEditingController(text: char.name),
          'description': TextEditingController(text: char.storygoal),
        });
      }
    }
    _initialized = true;
  }

  @override
  void dispose() {
    for (var controllerMap in _characterControllers) {
      controllerMap['name']?.dispose();
      controllerMap['description']?.dispose();
    }
    super.dispose();
  }

  void _addCharacterField() {
    if (_characterControllers.length < _maxCharacters) {
      setState(() {
        _characterControllers.add({
          'name': TextEditingController(),
          'description': TextEditingController(),
        });
      });
    }
  }

  void _removeCharacterField(int index) {
    if (_characterControllers.length > 1) {
      setState(() {
        _characterControllers[index]['name']?.dispose();
        _characterControllers[index]['description']?.dispose();
        _characterControllers.removeAt(index);
      });
    }
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;

    final cubit = context.read<AppCubit>();
    final currentCharacters = _characterControllers
        .map((controllerMap) => Character(
              name: controllerMap['name']!.text.trim(),
              storygoal: controllerMap['description']!.text.trim(),
            ))
        .where((character) =>
            character.name.isNotEmpty && character.storygoal.isNotEmpty)
        .toList();

    cubit.setCharacters(currentCharacters);
    cubit.saveCurrentProjectToDisk();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Main characters saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWrapper(
        child: SingleChildScrollView(
          padding: ResponsiveHelper.getContentPadding(context),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step 5: Main characters',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Describe the main characters of your story (maximum $_maxCharacters).',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ..._characterControllers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final controllers = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Character ${index + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                if (_characterControllers.length > 1)
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _removeCharacterField(index),
                                    tooltip: 'Delete character',
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: controllers['name'],
                              decoration: const InputDecoration(
                                labelText: 'Character name',
                                hintText: 'E.g. Aragorn',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                      ? 'Name is required'
                                      : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: controllers['description'],
                              maxLines: 4,
                              decoration: const InputDecoration(
                                labelText: 'Character description',
                                hintText:
                                    'Role, motivation, conflict, goals...',
                                border: OutlineInputBorder(),
                                alignLabelWithHint: true,
                              ),
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                      ? 'Description is required'
                                      : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                if (_characterControllers.length < _maxCharacters)
                  OutlinedButton.icon(
                    onPressed: _addCharacterField,
                    icon: const Icon(Icons.add),
                    label: const Text('Add character'),
                  ),
                const SizedBox(height: 24),
                SaveProjectButton(onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
