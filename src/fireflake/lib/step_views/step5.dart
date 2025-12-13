import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/character.dart';
import '../state/app_cubit.dart';

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
    
    // Limpiar personajes actuales y agregar los nuevos
    final currentCharacters = List<Character>.from(cubit.state.characters);
    currentCharacters.clear();

    for (var controllerMap in _characterControllers) {
      final name = controllerMap['name']!.text.trim();
      final description = controllerMap['description']!.text.trim();
      if (name.isNotEmpty && description.isNotEmpty) {
        currentCharacters.add(Character(name: name, storygoal: description));
      }
    }

    // Actualizar el estado con los personajes
    for (var char in currentCharacters) {
      cubit.addCharacter(char);
    }

    cubit.saveCurrentProjectToDisk();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Personajes principales guardados')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paso 5: Personajes principales',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Describe los personajes principales de tu historia (máximo $_maxCharacters).',
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
                                'Personaje ${index + 1}',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              if (_characterControllers.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () => _removeCharacterField(index),
                                  tooltip: 'Eliminar personaje',
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: controllers['name'],
                            decoration: const InputDecoration(
                              labelText: 'Nombre del personaje',
                              hintText: 'Ej: Aragorn',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) => (value == null || value.trim().isEmpty)
                                ? 'El nombre es requerido'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: controllers['description'],
                            maxLines: 4,
                            decoration: const InputDecoration(
                              labelText: 'Descripción del personaje',
                              hintText: 'Rol, motivación, conflicto, objetivos...',
                              border: OutlineInputBorder(),
                              alignLabelWithHint: true,
                            ),
                            validator: (value) => (value == null || value.trim().isEmpty)
                                ? 'La descripción es requerida'
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
                  label: const Text('Agregar personaje'),
                ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar personajes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
