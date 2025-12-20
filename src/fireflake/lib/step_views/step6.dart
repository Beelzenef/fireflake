import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/app_cubit.dart';
import '../widgets/save_project_button.dart';

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
      const SnackBar(content: Text('Extended argument saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final project = state.selectedProject;
          if (project == null) {
            return const Center(
                child: Text('Select or create a project first'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step 6: Expand argument',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Return to Step 4 and expand the argument with more narrative detail. Integrate conflicts, twists, and character development.',
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
                            'Extended argument',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Combine the paragraphs from Step 4 and add more depth: internal conflicts, subplots, twists, relationship arcs...',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _argumentController,
                            maxLines: 15,
                            decoration: const InputDecoration(
                              labelText: 'Full expanded argument',
                              hintText:
                                  'Write multiple paragraphs with the full argument, integrating all narrative elements...',
                              border: OutlineInputBorder(),
                              alignLabelWithHint: true,
                            ),
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                    ? 'The extended argument is required'
                                    : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SaveProjectButton(onPressed: _save),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
