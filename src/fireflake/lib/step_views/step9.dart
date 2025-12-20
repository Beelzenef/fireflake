import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/scene.dart';
import '../state/app_cubit.dart';
import '../widgets/save_project_button.dart';

class StepNinePage extends StatefulWidget {
  const StepNinePage({super.key});

  @override
  State<StepNinePage> createState() => _StepNinePageState();
}

class _StepNinePageState extends State<StepNinePage>
    with TickerProviderStateMixin {
  bool _isPanelOpen = false;
  Scene? _editingScene;
  int? _editingIndex;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _chapterController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _idController.dispose();
    _chapterController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Scene List',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton.icon(
                      onPressed: _addNewScene,
                      icon: const Icon(Icons.add),
                      label: const Text('Add New Scene'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        final scenes = state.scenes;
                        if (scenes.isEmpty) {
                          return const Center(
                              child: Text('No scenes yet. Add the first one.'));
                        }
                        return SingleChildScrollView(
                          child: DataTable(
                            columnSpacing: 20,
                            dataRowMinHeight: 80,
                            dataRowMaxHeight: 80,
                            headingRowColor: WidgetStateProperty.all(
                              Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.15),
                            ),
                            columns: const [
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Scene',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Chapter',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Summary',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Actions',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                            rows: scenes.asMap().entries.map((entry) {
                              final index = entry.key;
                              final scene = entry.value;
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        scene.id,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(scene.chapter),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        scene.summary,
                                        softWrap: true,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 20),
                                            onPressed: index > 0
                                                ? () => _moveSceneUp(index)
                                                : null,
                                            tooltip: 'Move up',
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 20),
                                            onPressed: index < scenes.length - 1
                                                ? () => _moveSceneDown(index)
                                                : null,
                                            tooltip: 'Move down',
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                size: 20),
                                            onPressed: () =>
                                                _editScene(scene, index),
                                            tooltip: 'Edit scene',
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                size: 20),
                                            onPressed: () =>
                                                _deleteScene(index),
                                            tooltip: 'Delete scene',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isPanelOpen)
            GestureDetector(
              onTap: _closeSidePanel,
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          if (_isPanelOpen)
            SlideTransition(
              position: _slideAnimation,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 400,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: _buildSidePanelContent(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _editScene(Scene scene, int index) {
    _editingScene = scene;
    _editingIndex = index;
    _idController.text = scene.id;
    _chapterController.text = scene.chapter;
    _summaryController.text = scene.summary;
    _openSidePanel();
  }

  void _deleteScene(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm delete'),
          content: const Text('Are you sure you want to delete this scene?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<AppCubit>().removeSceneAt(index);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _moveSceneUp(int index) {
    context.read<AppCubit>().moveSceneUp(index);
  }

  void _moveSceneDown(int index) {
    context.read<AppCubit>().moveSceneDown(index);
  }

  void _addNewScene() {
    final scenesLength = context.read<AppCubit>().state.scenes.length;
    _editingScene = null;
    _editingIndex = null;
    _idController.text = 'Scene ${scenesLength + 1}';
    _chapterController.text = 'Chapter ${(scenesLength ~/ 2) + 1}';
    _summaryController.text = '';
    _openSidePanel();
  }

  void _openSidePanel() {
    setState(() {
      _isPanelOpen = true;
    });
    _animationController.forward();
  }

  void _closeSidePanel() {
    _animationController.reverse().then((_) {
      setState(() {
        _isPanelOpen = false;
        _editingScene = null;
        _editingIndex = null;
      });
    });
  }

  void _saveScene() {
    if (_formKey.currentState!.validate()) {
      final newScene = Scene(
        id: _idController.text,
        chapter: _chapterController.text,
        summary: _summaryController.text,
      );
      if (_editingIndex != null) {
        context.read<AppCubit>().updateScene(_editingIndex!, newScene);
      } else {
        context.read<AppCubit>().addScene(newScene);
      }
      context.read<AppCubit>().saveCurrentProjectToDisk();
      _closeSidePanel();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(_editingIndex != null ? 'Scene updated' : 'New scene added'),
        ),
      );
    }
  }

  Widget _buildSidePanelContent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _editingScene != null ? 'Edit Scene' : 'New Scene',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: _closeSidePanel,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'Scene name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _chapterController,
                    decoration: const InputDecoration(
                      labelText: 'Chapter',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _summaryController,
                      decoration: const InputDecoration(
                        labelText: 'Scene summary',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        if (value.length < 50) {
                          return 'Summary must have at least 50 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _closeSidePanel,
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SaveProjectButton(
                          label: _editingScene != null
                              ? 'Update Scene'
                              : 'Save Scene',
                          onPressed: _saveScene,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
