import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/app_cubit.dart';
import '../utils/responsive_helper.dart';

class ProjectInfoPage extends StatefulWidget {
  const ProjectInfoPage({super.key});

  @override
  State<ProjectInfoPage> createState() => _ProjectInfoPageState();
}

class _ProjectInfoPageState extends State<ProjectInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _wordCountController = TextEditingController();
  bool _initializedFromState = false;

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _wordCountController.dispose();
    super.dispose();
  }

  void _saveProject() async {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<AppCubit>();
      final wordCount = int.parse(_wordCountController.text);
      cubit.saveProject(
        title: _titleController.text.trim(),
        subtitle: _subtitleController.text.trim(),
        expectedWordCount: wordCount,
      );
      await cubit.saveCurrentProjectToDisk();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Project saved'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _clearForm() {
    _titleController.clear();
    _subtitleController.clear();
    _wordCountController.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initializedFromState) return;
    final project = context.read<AppCubit>().state.selectedProject;
    if (project != null) {
      _titleController.text = project.title;
      _subtitleController.text = project.subtitle;
      _wordCountController.text = project.expectedWordCount.toString();
    }
    _initializedFromState = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWrapper(
        child: Padding(
          padding: ResponsiveHelper.getContentPadding(context),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project Information',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fill in the basic information for your writing project',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Project title',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    labelText: 'Title',
                                    hintText: 'E.g. The Shadow Kingdom',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.title),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Title is required';
                                    }
                                    if (value.trim().length < 3) {
                                      return 'Title must be at least 3 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Subtitle',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Short description or tagline of the project',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _subtitleController,
                                  decoration: const InputDecoration(
                                    labelText: 'Subtitle',
                                    hintText: 'E.g. An epic fantasy adventure',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.short_text),
                                  ),
                                  maxLines: 2,
                                  validator: (value) {
                                    if (value != null &&
                                        value.isNotEmpty &&
                                        value.trim().length < 10) {
                                      return 'Subtitle must have at least 10 characters or be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Word count',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Approximate total to complete the project',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _wordCountController,
                                  decoration: const InputDecoration(
                                    labelText: 'Word count',
                                    hintText: 'E.g. 80000',
                                    border: OutlineInputBorder(),
                                    prefixIcon:
                                        Icon(Icons.format_list_numbered),
                                    suffixText: 'words',
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Word count is required';
                                    }
                                    final int? wordCount = int.tryParse(value);
                                    if (wordCount == null) {
                                      return 'Enter a valid number';
                                    }
                                    if (wordCount < 1000) {
                                      return 'Word count must be at least 1,000';
                                    }
                                    if (wordCount > 1000000) {
                                      return 'Word count cannot exceed 1,000,000';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: Colors.blue.shade700),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Word count reference:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '• Novella: 50,000 - 80,000 words\n'
                                      '• Standard novel: 80,000 - 100,000 words\n'
                                      '• Epic novel: 100,000+ words',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _clearForm,
                          icon: const Icon(Icons.clear),
                          label: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: _saveProject,
                          icon: const Icon(Icons.save),
                          label: const Text('Save Project'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
