import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/app_cubit.dart';

class StepOnePage extends StatefulWidget {
  const StepOnePage({super.key});

  @override
  State<StepOnePage> createState() => _StepOnePageState();
}

class _StepOnePageState extends State<StepOnePage> {
  final _formKey = GlobalKey<FormState>();
  final _summaryController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    final project = context.read<AppCubit>().state.selectedProject;
    if (project != null) {
      _summaryController.text = project.summary;
    }
    _initialized = true;
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;
    context.read<AppCubit>().updateProjectSummary(
          summary: _summaryController.text.trim(),
        );
    context.read<AppCubit>().saveCurrentProjectToDisk();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resumen guardado')),
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
                'Paso 1: Resumen en una frase',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Escribe el resumen de tu historia en una sola frase. Este será el corazón de tu proyecto.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resumen en una frase',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _summaryController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Tu historia en una sola frase',
                          hintText: 'Ejemplo: Un joven mago descubre que es el elegido para salvar el mundo de la oscuridad.',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => (value == null || value.trim().isEmpty)
                            ? 'El resumen es requerido'
                            : null,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
