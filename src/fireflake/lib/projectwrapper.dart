import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'info_views/projectinfo.dart';
import 'step_views/step1.dart';
import 'step_views/step2.dart';
import 'step_views/step3.dart';
import 'step_views/step4.dart';
import 'step_views/step5.dart';
import 'step_views/step6.dart';
import 'step_views/step7.dart';
import 'step_views/step8.dart';
import 'step_views/step9.dart';
import 'state/app_cubit.dart';

class ProjectWrapper extends StatefulWidget {
  const ProjectWrapper({super.key});

  @override
  State<ProjectWrapper> createState() => _ProjectWrapperState();
}

class _ProjectWrapperState extends State<ProjectWrapper> {
  bool _allowPop = false;
  bool _confirmingLeave = false;

  @override
  Widget build(BuildContext context) {
    const steps = [
      ProjectInfoPage(),
      StepOnePage(),
      StepTwoPage(),
      StepThreePage(),
      StepFourPage(),
      StepFivePage(),
      StepSixPage(),
      StepSevenPage(),
      StepEightPage(),
      StepNinePage()
    ];

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => PopScope(
        canPop: _allowPop || state.dirtySections.isEmpty,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && state.dirtySections.isNotEmpty) {
            _confirmLeaveProject(context);
          }
        },
        child: DefaultTabController(
          length: steps.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(state.selectedProject?.title ?? 'Project'),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(child: _saveStatus(state.saveStatus)),
                ),
              ],
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Info'),
                  Tab(text: 'Step 1'),
                  Tab(text: 'Step 2'),
                  Tab(text: 'Step 3'),
                  Tab(text: 'Step 4'),
                  Tab(text: 'Step 5'),
                  Tab(text: 'Step 6'),
                  Tab(text: 'Step 7'),
                  Tab(text: 'Step 8'),
                  Tab(text: 'Step 9'),
                ],
              ),
            ),
            body: const TabBarView(
              children: steps,
            ),
          ),
        ),
      ),
    );
  }

  Widget _saveStatus(ProjectSaveStatus status) {
    final (label, icon, color) = switch (status) {
      ProjectSaveStatus.saved => (
          'Saved',
          Icons.cloud_done_outlined,
          Colors.green
        ),
      ProjectSaveStatus.unsaved => (
          'Unsaved changes',
          Icons.edit_outlined,
          Colors.orange
        ),
      ProjectSaveStatus.saving => ('Saving...', Icons.sync, Colors.blue),
      ProjectSaveStatus.error => (
          'Save failed',
          Icons.error_outline,
          Colors.red
        ),
    };
    return Tooltip(
      message: label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontSize: 13)),
        ],
      ),
    );
  }

  Future<void> _confirmLeaveProject(BuildContext context) async {
    if (_confirmingLeave) return;
    _confirmingLeave = true;
    final navigator = Navigator.of(context);
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved changes'),
        content: const Text(
          'Leave this project without saving? Your unsaved edits will be discarded.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep editing'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Discard and leave'),
          ),
        ],
      ),
    );
    _confirmingLeave = false;
    if (shouldLeave != true || !mounted) return;
    setState(() => _allowPop = true);
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) navigator.pop();
  }
}
