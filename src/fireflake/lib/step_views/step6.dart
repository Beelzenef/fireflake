import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/app_cubit.dart';

class StepSixPage extends StatefulWidget {
  const StepSixPage({super.key});

  @override
  State<StepSixPage> createState() => _StepSixPageState();
}

class _StepSixPageState extends State<StepSixPage> {
  final _formKey = GlobalKey<FormState>();
  final _argumentController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _argumentController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final project = context.read<AppCubit>().state.selectedProject;
    if (project != null) {
      _argumentController.text = project.extendedArgument;
    }
    _initialized = true;
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;

    final cubit = context.read<AppCubit>();
    cubit.updateExtendedArgument(_argumentController.text.trim());
    cubit.saveCurrentProjectToDisk();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Argumento ampliado guardado')),
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
                    'Paso 6: Ampliar argumento',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vuelve al Paso 4 y amplía el argumento con más detalle narrativo. Integra conflictos, giros y desarrollo de personajes.',
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
                            'Argumento extendido',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Combina los párrafos del Paso 4 y añade más profundidad: conflictos internos, secundarios, giros de trama, desarrollo de relaciones...',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _argumentController,
                            maxLines: 15,
                            decoration: const InputDecoration(
                              labelText: 'Argumento completo ampliado',
                              hintText: 'Escribe varios párrafos con el argumento completo, integrando todos los elementos narrativos...',
                              border: OutlineInputBorder(),
                              alignLabelWithHint: true,
                            ),
                            validator: (value) => (value == null || value.trim().isEmpty)
                                ? 'El argumento ampliado es requerido'
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
                      label: const Text('Guardar argumento ampliado'),
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
