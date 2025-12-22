import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/app_cubit.dart';
import '../widgets/save_project_button.dart';
import '../utils/responsive_helper.dart';

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
      const SnackBar(content: Text('Summary saved')),
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
                  'Step 1: One-sentence summary',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Write your story in a single sentence. This is the core of your project.',
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
                          'One-sentence summary',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _summaryController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Your story in one sentence',
                            hintText:
                                'Example: A young witch learns they are the chosen one to save the world from darkness.',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                                  ? 'Summary is required'
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
        ),
      ),
    );
  }
}
