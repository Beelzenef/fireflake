import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/protagonist.dart';
import '../state/app_cubit.dart';
import '../widgets/save_project_button.dart';
import '../utils/responsive_helper.dart';
import '../utils/project_save.dart';

class StepThreePage extends StatefulWidget {
  const StepThreePage({super.key});

  @override
  State<StepThreePage> createState() => _StepThreePageState();
}

class _StepThreePageState extends State<StepThreePage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _historyControllers = [];
  final TextEditingController _motivationsController = TextEditingController();
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _conflictController = TextEditingController();
  final TextEditingController _epiphanyController = TextEditingController();
  final List<TextEditingController> _finalHistoryControllers = [];
  bool _initialized = false;

  @override
  void dispose() {
    for (var controller in _historyControllers) {
      controller.dispose();
    }
    for (var controller in _finalHistoryControllers) {
      controller.dispose();
    }
    _motivationsController.dispose();
    _objectiveController.dispose();
    _conflictController.dispose();
    _epiphanyController.dispose();
    super.dispose();
  }

  void _addHistoryField() {
    setState(() {
      _historyControllers.add(TextEditingController());
    });
  }

  void _removeHistoryField(int index) {
    if (_historyControllers.length > 1) {
      setState(() {
        _historyControllers[index].dispose();
        _historyControllers.removeAt(index);
      });
    }
  }

  void _addFinalHistoryField() {
    setState(() {
      _finalHistoryControllers.add(TextEditingController());
    });
  }

  void _removeFinalHistoryField(int index) {
    if (_finalHistoryControllers.length > 1) {
      setState(() {
        _finalHistoryControllers[index].dispose();
        _finalHistoryControllers.removeAt(index);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final protagonist =
        context.read<AppCubit>().state.selectedProject?.protagonist;
    if (protagonist != null) {
      _historyControllers.addAll(protagonist.storyElements
          .map((element) => TextEditingController(text: element)));
      _motivationsController.text = protagonist.motivations;
      _objectiveController.text = protagonist.goal;
      _conflictController.text = protagonist.conflict;
      _epiphanyController.text = protagonist.epiphany;
      _finalHistoryControllers.addAll(protagonist.finalStoryElements
          .map((element) => TextEditingController(text: element)));
    }

    if (_historyControllers.isEmpty) {
      _historyControllers.add(TextEditingController());
    }
    if (_finalHistoryControllers.isEmpty) {
      _finalHistoryControllers.add(TextEditingController());
    }
    _initialized = true;
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() != true) return;

    final cubit = context.read<AppCubit>();
    await saveProjectWithFeedback(
      context,
      update: () => cubit.updateProtagonist(Protagonist(
        storyElements: _historyControllers
            .map((controller) => controller.text.trim())
            .toList(),
        motivations: _motivationsController.text.trim(),
        goal: _objectiveController.text.trim(),
        conflict: _conflictController.text.trim(),
        epiphany: _epiphanyController.text.trim(),
        finalStoryElements: _finalHistoryControllers
            .map((controller) => controller.text.trim())
            .toList(),
      )),
      successMessage: 'Protagonist information saved',
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
                const Text(
                  'Character Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Backstory (single-sentence elements)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ..._historyControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Story element ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeHistoryField(index),
                        ),
                      ],
                    ),
                  );
                }),
                TextButton.icon(
                  onPressed: _addHistoryField,
                  icon: const Icon(Icons.add),
                  label: const Text('Add story element'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _motivationsController,
                  decoration: const InputDecoration(
                    labelText: 'Motivations',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _objectiveController,
                  decoration: const InputDecoration(
                    labelText: 'Goal',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _conflictController,
                  decoration: const InputDecoration(
                    labelText: 'Conflict',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _epiphanyController,
                  decoration: const InputDecoration(
                    labelText: 'Epiphany',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Final backstory (single-sentence elements)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ..._finalHistoryControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Final story element ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeFinalHistoryField(index),
                        ),
                      ],
                    ),
                  );
                }),
                TextButton.icon(
                  onPressed: _addFinalHistoryField,
                  icon: const Icon(Icons.add),
                  label: const Text('Add final story element'),
                ),
                const SizedBox(height: 30),
                SaveProjectButton(onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
