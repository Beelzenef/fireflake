import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/app_cubit.dart';

class StepEightPage extends StatefulWidget {
  const StepEightPage({super.key});

  @override
  State<StepEightPage> createState() => _StepEightPageState();
}

class _StepEightPageState extends State<StepEightPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _sceneControllers = [];
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _addSceneField();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final project = context.read<AppCubit>().state.selectedProject;
    if (project != null && project.pendingScenes.isNotEmpty) {
      _sceneControllers.clear();
      for (final scene in project.pendingScenes) {
        _sceneControllers.add(TextEditingController(text: scene));
      }
    }
    _initialized = true;
  }

  @override
  void dispose() {
    for (var controller in _sceneControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addSceneField() {
    setState(() {
      _sceneControllers.add(TextEditingController());
    });
  }

  void _removeSceneField(int index) {
    if (_sceneControllers.length > 1) {
      setState(() {
        _sceneControllers[index].dispose();
        _sceneControllers.removeAt(index);
      });
    }
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;

    final cubit = context.read<AppCubit>();
    final scenes = _sceneControllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    cubit.updatePendingScenes(scenes);
    cubit.saveCurrentProjectToDisk();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lista de escenas guardada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final project = state.selectedProject;
          if (project == null) {
            return const Center(child: Text('Selecciona o crea un proyecto primero'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paso 8: Lista de escenas',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Usando el argumento ampliado del Paso 6, escribe una lista de las escenas que faltan para completar la historia.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  ..._sceneControllers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final controller = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    labelText: 'Escena ${index + 1}',
                                    hintText: 'Describe brevemente la escena...',
                                    border: const OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  validator: (value) => (value == null || value.trim().isEmpty)
                                      ? 'Requerido'
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (_sceneControllers.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                  onPressed: () => _removeSceneField(index),
                                  tooltip: 'Eliminar',
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _addSceneField,
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar escena'),
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar lista de escenas'),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: Colors.amber.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Después de guardar esta lista, ve al Paso 9 para escribir el resumen narrativo de cada escena.',
                            style: TextStyle(color: Colors.amber.shade900),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
