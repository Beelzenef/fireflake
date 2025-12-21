import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/app_cubit.dart';
import '../widgets/save_project_button.dart';
import '../utils/responsive_helper.dart';

class StepTwoPage extends StatefulWidget {
  const StepTwoPage({super.key});

  @override
  State<StepTwoPage> createState() => _StepTwoPageState();
}

class _StepTwoPageState extends State<StepTwoPage> {
  final _formKey = GlobalKey<FormState>();
  final _summaryController = TextEditingController();
  final _act1Controller = TextEditingController();
  final _act2Controller = TextEditingController();
  final _act3Controller = TextEditingController();
  final _finaleController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _summaryController.dispose();
    _act1Controller.dispose();
    _act2Controller.dispose();
    _act3Controller.dispose();
    _finaleController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    final project = context.read<AppCubit>().state.selectedProject;
    if (project != null) {
      _summaryController.text = project.summary;
      _act1Controller.text = project.act1;
      _act2Controller.text = project.act2;
      _act3Controller.text = project.act3;
      _finaleController.text = project.finale;
    }
    _initialized = true;
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;
    context.read<AppCubit>().updateProjectSummary(
          summary: _summaryController.text.trim(),
          act1: _act1Controller.text.trim(),
          act2: _act2Controller.text.trim(),
          act3: _act3Controller.text.trim(),
          finale: _finaleController.text.trim(),
        );
    context.read<AppCubit>().saveCurrentProjectToDisk();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expanded summary saved')),
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
                  'Expand the summary',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Break the summary into main acts and finale to structure the story.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                _buildCard(
                  context,
                  title: 'Overall summary',
                  child: TextFormField(
                    controller: _summaryController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Overall project summary',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Summary is required'
                            : null,
                  ),
                ),
                const SizedBox(height: 16),
                _buildCard(
                  context,
                  title: 'Act I',
                  child: TextFormField(
                    controller: _act1Controller,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Setup / Act I',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Describe Act I'
                            : null,
                  ),
                ),
                const SizedBox(height: 12),
                _buildCard(
                  context,
                  title: 'Act II',
                  child: TextFormField(
                    controller: _act2Controller,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Confrontation / Act II',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Describe Act II'
                            : null,
                  ),
                ),
                const SizedBox(height: 12),
                _buildCard(
                  context,
                  title: 'Act III',
                  child: TextFormField(
                    controller: _act3Controller,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Climax / Act III',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Describe Act III'
                            : null,
                  ),
                ),
                const SizedBox(height: 12),
                _buildCard(
                  context,
                  title: 'Finalr',
                  child: TextFormField(
                    controller: _finaleController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Resolution / Finale',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Describe the ending'
                            : null,
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

  Widget _buildCard(BuildContext context,
      {required String title, required Widget child}) {
    return Card(
      elevation: ResponsiveHelper.getCardElevation(context),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.isMobile(context) ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
