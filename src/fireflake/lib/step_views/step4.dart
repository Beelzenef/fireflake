import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/app_cubit.dart';

class StepFourPage extends StatefulWidget {
  const StepFourPage({super.key});

  @override
  State<StepFourPage> createState() => _StepFourPageState();
}

class _StepFourPageState extends State<StepFourPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _initialized = false;

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final project = context.read<AppCubit>().state.selectedProject;
    if (project == null) return;

    _controllers['act1'] = TextEditingController(
        text:
            project.expandedAct1.isEmpty ? project.act1 : project.expandedAct1);
    _controllers['act2'] = TextEditingController(
        text:
            project.expandedAct2.isEmpty ? project.act2 : project.expandedAct2);
    _controllers['act3'] = TextEditingController(
        text:
            project.expandedAct3.isEmpty ? project.act3 : project.expandedAct3);
    _controllers['finale'] = TextEditingController(
        text: project.expandedFinale.isEmpty
            ? project.finale
            : project.expandedFinale);

    _initialized = true;
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;

    final cubit = context.read<AppCubit>();
    cubit.updateExpandedParagraphs(
      expandedAct1: _controllers['act1']!.text.trim(),
      expandedAct2: _controllers['act2']!.text.trim(),
      expandedAct3: _controllers['act3']!.text.trim(),
      expandedFinale: _controllers['finale']!.text.trim(),
    );
    cubit.saveCurrentProjectToDisk();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expanded paragraphs saved')),
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

          if (project.act1.isEmpty &&
              project.act2.isEmpty &&
              project.act3.isEmpty &&
              project.finale.isEmpty) {
            return const Center(
                child: Text('Complete Step 2 first (acts and finale)'));
          }

          if (!_initialized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {});
            });
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step 4: Expand into paragraphs',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Turn each sentence from Step 2 into a full paragraph.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  if (project.act1.isNotEmpty) ...[
                    _buildExpandedSection(
                        context, 'Acto I - Expandido', 'act1'),
                    const SizedBox(height: 16),
                  ],
                  if (project.act2.isNotEmpty) ...[
                    _buildExpandedSection(
                        context, 'Acto II - Expandido', 'act2'),
                    const SizedBox(height: 16),
                  ],
                  if (project.act3.isNotEmpty) ...[
                    _buildExpandedSection(
                        context, 'Acto III - Expandido', 'act3'),
                    const SizedBox(height: 16),
                  ],
                  if (project.finale.isNotEmpty) ...[
                    _buildExpandedSection(
                        context, 'Final - Expandido', 'finale'),
                    const SizedBox(height: 16),
                  ],
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save),
                      label: const Text('Save expanded paragraphs'),
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

  Widget _buildExpandedSection(BuildContext context, String title, String key) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _controllers[key],
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Full paragraph for $title',
                hintText:
                    'Expand the sentence from Step 2 into a richer narrative paragraph...',
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'This paragraph is required'
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
